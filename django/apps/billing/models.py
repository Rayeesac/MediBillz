from django.db import models
from django.contrib.auth.models import User
from apps.medicines.models import Medicine

class Bill(models.Model):
    staff = models.ForeignKey(User, on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)

class BillItem(models.Model):
    bill = models.ForeignKey(Bill, related_name="items", on_delete=models.CASCADE)
    medicine = models.ForeignKey(Medicine, on_delete=models.CASCADE)
    quantity = models.PositiveIntegerField()
    packaging_type = models.CharField(max_length=10, choices=[
        ("single", "Single"),
        ("strip", "Strip"),
        ("pack", "Pack"),
        ("box", "Box"),
    ])
    price = models.DecimalField(max_digits=10, decimal_places=2)

    def save(self, *args, **kwargs):

        """Calculate price and check stock availability before saving."""
        price_map = {
            "single": self.medicine.single_price,
            "strip": self.medicine.strip_price,
            "pack": self.medicine.pack_price,
            "box": self.medicine.box_price,
        }

        selected_price = price_map.get(self.packaging_type)
        if selected_price is None:
            raise ValueError(f"Invalid packaging type price: {self.packaging_type}")
        
        total_price = selected_price * self.quantity

        """Deduct stock based on the selected packaging type."""
        stock_map = {
            "single": "single_stock",
            "strip": "strip_stock",
            "pack": "pack_stock",
            "box": "box_stock",
        }

        stock_field = stock_map.get(self.packaging_type)
        if not stock_field:
            raise ValueError(f"Invalid packaging type stock: {self.packaging_type}")
        
        current_stock = getattr(self.medicine, stock_field)

        if current_stock < self.quantity:
            raise ValueError(f"Not enough stock for {self.medicine.name} ({self.packaging_type}).")

        # Deduct stock
        self.medicine.reduce_stock(self.packaging_type, self.quantity)
        self.medicine.save()

        self.price = total_price
        super().save(*args, **kwargs)