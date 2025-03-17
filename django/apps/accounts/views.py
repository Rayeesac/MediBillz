from django.contrib.auth.models import User
from rest_framework import generics, status, permissions
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework_simplejwt.tokens import RefreshToken
from .serializers import UserSerializer
from medi_conf.permissions import IsAdminUser

class UserListCreateView(generics.ListCreateAPIView):
    """Admin-only view to list and create users with assigned roles (groups)."""
    queryset = User.objects.all()
    serializer_class = UserSerializer
    permission_classes = [IsAdminUser]

class LogoutView(APIView):
    """Logout API that invalidates the JWT refresh token for the user."""

    permission_classes = [permissions.IsAuthenticated]

    def post(self, request):
        try:
            refresh_token = request.data.get("refresh_token")
            if not refresh_token:
                return Response({"error": "Refresh token is required"}, status=status.HTTP_400_BAD_REQUEST)

            # Create a refresh token instance and delete it (invalidating it)
            token = RefreshToken(refresh_token)
            return Response({"message": "Successfully logged out"}, status=status.HTTP_200_OK)

        except Exception:
            return Response({"error": "Invalid token"}, status=status.HTTP_400_BAD_REQUEST)

class UserListView(generics.ListAPIView):
    """🔹 GET /api/users/ → Get all users (Admin only)"""
    queryset = User.objects.all().exclude(is_superuser=True)
    serializer_class = UserSerializer
    permission_classes = [IsAdminUser]


class UserDetailView(generics.RetrieveUpdateDestroyAPIView):
    """🔹 GET /api/users/{id}/ → Get a specific user
       🔹 PUT /api/users/{id}/ → Update user details
       🔹 DELETE /api/users/{id}/ → Delete a user
    """
    queryset = User.objects.all()
    serializer_class = UserSerializer
    permission_classes = [IsAdminUser]