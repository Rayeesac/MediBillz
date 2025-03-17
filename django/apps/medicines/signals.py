from django.db.models.signals import post_save
from django.dispatch import receiver
from django.core.mail import send_mail
from django.utils.timezone import now
from django.conf import settings
from .models import Medicine

@receiver(post_save, sender=Medicine)
def notify_admins_on_low_stock(sender, instance, **kwargs):
    """Send an email if any packaging type has low stock or medicine is expired."""

    # Define low stock threshold (Customize as needed)
    LOW_STOCK_THRESHOLD = settings.LOW_STOCK_THRESHOLD

    # Check stock levels for all packaging types
    low_stock = (
        (instance.single_stock is not None and instance.single_stock <= LOW_STOCK_THRESHOLD) or
        (instance.strip_stock is not None and instance.strip_stock <= LOW_STOCK_THRESHOLD) or
        (instance.pack_stock is not None and instance.pack_stock <= LOW_STOCK_THRESHOLD) or
        (instance.box_stock is not None and instance.box_stock <= LOW_STOCK_THRESHOLD)
    )

    # Check if the medicine is expired
    expired = instance.expiry_date and instance.expiry_date < now().date()

    # Send alert if stock is low or expired
    if low_stock or expired:
        subject = "⚠️ Medicine Alert: Low Stock / Expired"
        message = f"""
        📢 Medicine Stock Alert
        
        Dear Inventory Manager,
        
        The following medicine requires urgent attention due to low stock levels or expiration:

        🔹 Medicine Name: {instance.name}  
        🔹 Category: {instance.category}  
        🔹 Expiry Date: {instance.expiry_date.strftime("%d-%m-%Y")}  
        
        📦 Stock Levels:  
        - 🏥 Single: {instance.single_stock} units  
        - 💊 Strip: {instance.strip_stock} strips  
        - 📦 Pack: {instance.pack_stock} packs  
        - 📦 Box: {instance.box_stock} boxes  

        🚨 Action Required:  
        - If expired: Please remove from inventory immediately.  
        - If low stock: Consider restocking to avoid supply disruption.  

        Thank you for your support.  

        Best regards,  
        {settings.SITE_NAME} System
        """

        send_mail(
            subject,
            message,
            settings.DEFAULT_FROM_EMAIL,
            [instance.inventory_manager.email],
            fail_silently=False,
        )
