from django.contrib.auth.models import Group, User
from rest_framework import serializers

class UserSerializer(serializers.ModelSerializer):
    """Serializer for Django's built-in User model with a single role (Group)."""

    group = serializers.SerializerMethodField()  # Read group as a string
    role = serializers.SlugRelatedField(
        queryset=Group.objects.all(),
        slug_field="name",
        write_only=True,  # Used only for input (create/update)
        required=True
    )
    password = serializers.CharField(write_only=True, required=True, min_length=6)

    class Meta:
        model = User
        fields = ["id", "username", "password", "email", "group", "role"]

    def get_group(self, obj):
        """Retrieve the first (and only) group name assigned to the user."""
        return obj.groups.first().name if obj.groups.exists() else None

    def create(self, validated_data):
        """Assign a single group to the user and hash password."""
        group_name = validated_data.pop("role", None)  # Get the group name
        password = validated_data.pop("password")  # Extract password
        user = User(**validated_data)
        user.set_password(password)  # Hash the password
        user.save()

        if group_name:
            group = Group.objects.get(name=group_name)
            user.groups.set([group])  # Ensure only one group is assigned
        return user

    def update(self, instance, validated_data):
        """Update user details while ensuring the password is hashed."""
        group_name = validated_data.pop("role", None)  # Get the new group name
        password = validated_data.pop("password", None)  # Extract password if provided

        instance = super().update(instance, validated_data)

        if password:
            instance.set_password(password)  # Hash the new password
            instance.save()

        if group_name:
            group = Group.objects.get(name=group_name)
            instance.groups.set([group])  # Replace the old group
        return instance