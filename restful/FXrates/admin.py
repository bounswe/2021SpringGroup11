from django.contrib import admin

# Register your models here.

from .models import Price
from .models import Comment

admin.site.register(Price)
admin.site.register(Comment)

