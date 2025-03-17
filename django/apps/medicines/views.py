from django.conf import settings
from django.db.models import Q
from django.db import models
from django.utils.timezone import now
from rest_framework import generics
from rest_framework.response import Response
from apps.medicines.models import Medicine
from apps.medicines.serializers import MedicineSerializer, MedicineStockSerializer
from medi_conf.permissions import IsInventoryManager, IsAdminUser

class MedicineListCreateView(generics.ListCreateAPIView):
    queryset = Medicine.objects.all()
    serializer_class = MedicineSerializer
    permission_classes = [IsInventoryManager]

    def perform_create(self, serializer):
        """Automatically set the inventory_manager to the logged-in user."""
        serializer.save(inventory_manager=self.request.user)

class MedicineDetailView(generics.RetrieveUpdateDestroyAPIView):
    queryset = Medicine.objects.all()
    serializer_class = MedicineSerializer
    permission_classes = [IsInventoryManager]

class MedicineStockView(generics.ListAPIView):
    queryset = Medicine.objects.filter(Q(single_stock__gt=0)| Q(strip_stock__gt=0) | Q(pack_stock__gt=0) | Q(box_stock__gt=0))
    serializer_class = MedicineStockSerializer
    permission_classes = [IsAdminUser]