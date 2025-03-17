from rest_framework import serializers
from .models import Bill, BillItem

class BillItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = BillItem
        fields = ["medicine", "quantity", "packaging_type"]

class BillSerializer(serializers.ModelSerializer):
    items = BillItemSerializer(many=True, write_only=True)  # For input only
    total_price = serializers.SerializerMethodField()  # Read-only field for total bill

    class Meta:
        model = Bill
        fields = ["id", "created_at", "items", "total_price"]

    def get_total_price(self, obj):
        """Calculate the total price of all bill items."""
        return sum(item.price for item in obj.items.all())

    def create(self, validated_data):
        """Create a Bill and associated BillItems."""
        items_data = validated_data.pop("items", [])
        bill = Bill.objects.create(**validated_data)

        for item_data in items_data:
            try:
                BillItem.objects.create(bill=bill, **item_data)
            except ValueError as e:
                raise serializers.ValidationError(str(e))

        return bill