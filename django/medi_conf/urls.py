from django.contrib import admin
from django.urls import path
from rest_framework_simplejwt.views import TokenObtainPairView
from apps.accounts.views import LogoutView, UserListCreateView, UserListView, UserDetailView
from apps.medicines.views import MedicineListCreateView, MedicineDetailView, MedicineStockView
from apps.billing.views import BillCreateView, SalesReportView

urlpatterns = [
    # Admin
    path("admin/", admin.site.urls),

    # JWT Authentication
    path("api/auth/login/", TokenObtainPairView.as_view(), name="login"),
    path("api/auth/logout/", LogoutView.as_view(), name="logout"),
    path("api/auth/register/", UserListCreateView.as_view(), name="register"),

    path("api/users/", UserListView.as_view(), name="user-list"),
    path("api/users/<int:pk>/", UserDetailView.as_view(), name="user-detail"),

    path("api/medicines/", MedicineListCreateView.as_view(), name="medicine-list"),
    path("api/medicines/<int:pk>/", MedicineDetailView.as_view(), name="medicine-detail"),

    path("api/billing/", BillCreateView.as_view(), name="create-bill"),

    path("api/dashboard/stock/", MedicineStockView.as_view(), name="available-medicine"),
    path("api/dashboard/reports/", SalesReportView.as_view(), name="sales-report"),
]