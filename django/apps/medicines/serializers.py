from rest_framework import serializers
from apps.medicines.models import Medicine

class MedicineSerializer(serializers.ModelSerializer):
    class Meta:
        model = Medicine
        fields = ["name", "category", "single_price", "strip_price", "pack_price", "box_price", "single_stock", "strip_stock", "pack_stock", "box_stock", "expiry_date"]

class MedicineStockSerializer(serializers.ModelSerializer):
    is_low_stock = serializers.SerializerMethodField()
    is_expired = serializers.SerializerMethodField()

    class Meta:
        model = Medicine
        fields = ["inventory_manager", "name", "single_stock", "strip_stock", "pack_stock", "box_stock", "is_low_stock", "is_expired"]

    def get_is_low_stock(self, obj):
        return obj.is_low_stock()

    def get_is_expired(self, obj):
        return obj.is_expired()