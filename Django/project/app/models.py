from django.db import models
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager, PermissionsMixin
from django.db import models
from django.dispatch import receiver
from django.db.models.signals import post_save
from django.conf import settings
from rest_framework.authtoken.models import Token
from django.contrib.auth.models import User
from .models import User
from django.contrib import admin
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin




@receiver(post_save , sender = settings.AUTH_USER_MODEL)
def createToken(sender , instance ,created , **kwargs):
    if created:
        Token.objects.create(user = instance)