from io import BytesIO
from django.conf import settings
from django.db.models import Sum, Count
from django.utils.dateparse import parse_date
from django.core.mail import EmailMessage
from rest_framework import status
from rest_framework import generics
from rest_framework.response import Response
from reportlab.lib.pagesizes import letter
from reportlab.pdfgen import canvas
from .models import Bill
from .serializers import BillSerializer
from medi_conf.permissions import IsAdminUser,IsStaffUser
from apps.medicines.models import Medicine

class BillCreateView(generics.CreateAPIView):
    queryset = Bill.objects.all()
    serializer_class = BillSerializer
    permission_classes = [IsStaffUser]

    def perform_create(self, serializer):
        """Automatically set the inventory_manager to the logged-in user."""
        serializer.save(staff=self.request.user)
    
    def create(self, request, *args, **kwargs):
        """
        Override the create method to validate medicine IDs before processing.
        """
        items_data = request.data.get("items", [])

        # Extract medicine IDs from request
        medicine_ids = [item.get("medicine") for item in items_data if "medicine" in item]
        existing_medicines = Medicine.objects.filter(id__in=medicine_ids).values_list("id", flat=True)

        # Find missing medicines
        missing_medicines = [med_id for med_id in medicine_ids if med_id not in existing_medicines]

        if missing_medicines:
            return Response(
                {"error": f"Invalid medicine ID(s): {', '.join(map(str, missing_medicines))}."},
                status=status.HTTP_400_BAD_REQUEST
            )

        # Create the bill
        response = super().create(request, *args, **kwargs)
        bill_id = response.data.get("id")

        if bill_id:
            # Fetch the created bill instance
            bill = Bill.objects.get(id=bill_id)

            # Generate and send invoice
            self.send_invoice_email(bill)

        return response

    def generate_invoice_pdf(self, bill):
        """
        Generate a PDF invoice for the given bill.
        """
        buffer = BytesIO()
        pdf = canvas.Canvas(buffer, pagesize=letter)
        pdf.setTitle(f"Invoice_{bill.id}.pdf")

        # Invoice Header
        pdf.setFont("Helvetica-Bold", 14)
        pdf.drawString(100, 750, f"Invoice ID: INV-{bill.id:05d}")
        pdf.drawString(100, 730, f"Staff: {bill.staff.username}")
        pdf.drawString(100, 710, f"Date: {bill.created_at.strftime('%Y-%m-%d %H:%M:%S')}")

        pdf.setFont("Helvetica-Bold", 12)
        pdf.drawString(100, 680, "Items:")

        y_position = 660
        total_price = 0

        # List Items
        for item in bill.items.all():
            item_text = f"{item.medicine.name} ({item.packaging_type}) x {item.quantity} = Rs {item.price}"
            pdf.setFont("Helvetica", 10)
            pdf.drawString(120, y_position, item_text)
            y_position -= 20
            total_price += item.price

        # Total Price
        pdf.setFont("Helvetica-Bold", 12)
        pdf.drawString(100, y_position - 20, f"Total Price: Rs {total_price}")

        pdf.showPage()
        pdf.save()

        buffer.seek(0)
        return buffer

    def send_invoice_email(self, bill):
        """
        Send invoice email with PDF attachment.
        """
        pdf_buffer = self.generate_invoice_pdf(bill)
        recipient_email = bill.staff.email  # Use actual customer email field if available
        subject = f"🧾 Invoice for Your Purchase (#{bill.id})"
        message = f"""
        Dear {bill.staff.username},

        Thank you for your purchase. Attached is your invoice.

        📌 Invoice ID: INV-{bill.id:05d}
        🏷️ Date: {bill.created_at.strftime('%Y-%m-%d %H:%M:%S')}
        💰 Total Amount: ₹{sum(item.price for item in bill.items.all())}

        If you have any questions, feel free to contact us.

        Best regards,  
        Your Pharmacy Team
        """

        email = EmailMessage(subject, message, settings.DEFAULT_FROM_EMAIL, [recipient_email])
        email.attach(f"Invoice_{bill.id}.pdf", pdf_buffer.getvalue(), "application/pdf")
        email.send()

class SalesReportView(generics.ListAPIView):
    permission_classes = [IsAdminUser]

    def get(self, request, *args, **kwargs):
        """Generate reports based on date range & staff-wise billing."""
        start_date = request.GET.get("start_date")
        end_date = request.GET.get("end_date")

        # Validate dates
        if not start_date or not end_date:
            return Response({"error": "Both start_date and end_date are required."}, status=400)
        try:
            start_date = parse_date(start_date)  # Convert string to date
            end_date = parse_date(end_date)

            if not start_date or not end_date:
                raise ValueError("Invalid date format")

            if start_date > end_date:
                return Response({"error": "start_date cannot be after end_date."}, status=400)

        except ValueError:
            return Response({"error": "Invalid date format. Use YYYY-MM-DD."}, status=400)

        # Filter bills within the date range
        bills = Bill.objects.filter(created_at__date__range=[start_date, end_date])

        # Aggregate data
        report_data = bills.values("staff__username").annotate(
            total_sales=Sum("items__price"),
            total_bills=Count("id")
        )

        return Response(report_data)