from datetime import date
from django.db import models
from django.conf import settings
from django.contrib.auth.models import User

class Medicine(models.Model):
    name = models.CharField(max_length=255, unique=True)
    CATEGORY_CHOICES = [
        ("tablet", "Tablet"),
        ("capsule", "Capsule"),
        ("syrup", "Syrup"),
        ("injection", "Injection"),
        ("ointment", "Ointment"),
        ("cream", "Cream"),
        ("drop", "Drop"),
        ("inhaler", "Inhaler"),
        ("other", "Other"),
    ]
    category = models.CharField(max_length=50, choices=CATEGORY_CHOICES)

    inventory_manager = models.ForeignKey(
        User, on_delete=models.CASCADE, related_name="managed_medicines"
    )

    single_price = models.DecimalField(max_digits=10, decimal_places=2)
    strip_price = models.DecimalField(max_digits=10, decimal_places=2, null=True, blank=True)
    pack_price = models.DecimalField(max_digits=10, decimal_places=2, null=True, blank=True)
    box_price = models.DecimalField(max_digits=10, decimal_places=2, null=True, blank=True)
    
    single_stock = models.PositiveIntegerField(default=0)
    strip_stock = models.PositiveIntegerField(default=0)
    pack_stock = models.PositiveIntegerField(default=0)
    box_stock = models.PositiveIntegerField(default=0)

    expiry_date = models.DateField()
    created_at = models.DateTimeField(auto_now_add=True)

    def reduce_stock(self, packaging_type, quantity):
        """Deduct stock based on packaging type."""
        if packaging_type == "single":
            self.single_stock = max(0, self.single_stock - quantity)
        elif packaging_type == "strip":
            self.strip_stock = max(0, self.strip_stock - quantity)
        elif packaging_type == "pack":
            self.pack_stock = max(0, self.pack_stock - quantity)
        elif packaging_type == "box":
            self.box_stock = max(0, self.box_stock - quantity)
        self.save()

    def is_expired(self):
        """Check if the medicine is expired."""
        return date.today() > self.expiry_date

    def is_low_stock(self):
        """Check if any stock type is below the threshold."""
        threshold = settings.LOW_STOCK_THRESHOLD
        return (
            self.single_stock <= threshold or
            self.strip_stock <= threshold or
            self.pack_stock <= threshold or
            self.box_stock <= threshold
        )

    def __str__(self):
        return f"{self.name}"