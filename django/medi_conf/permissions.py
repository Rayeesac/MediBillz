from rest_framework import permissions

class IsAdminUser(permissions.BasePermission):
    """Allows access only to users in the 'Admin' group."""
    
    def has_permission(self, request, view):
        return request.user.is_authenticated and request.user.groups.filter(name="Admin").exists()

class IsStaffUser(permissions.BasePermission):
    """Allows access only to users in the 'Staff' group."""
    
    def has_permission(self, request, view):
        return request.user.is_authenticated and request.user.groups.filter(name="Staff").exists()

class IsInventoryManager(permissions.BasePermission):
    """Allows access only to users in the 'Inventory Manager' group."""
    
    def has_permission(self, request, view):
        return request.user.is_authenticated and request.user.groups.filter(name="Inventory Manager").exists()