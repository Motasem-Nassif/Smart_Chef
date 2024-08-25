from rest_framework import serializers
from .models import User  # Replace with the correct import for your User model

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['username', 'email', 'password', 'first_name', 'last_name','diseases']  # Include fields as per your model

    def create(self, validated_data):
        user = User(
            username=validated_data['username'],
            email=validated_data['email'],
            diseases = validated_data['diseases']
        )
        user.set_password(validated_data['password'])  # Set the password securely
        user.save()
        return user
    
class UserProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = User  # Use your custom User model if applicable
        fields = ['username', 'email','diseases']