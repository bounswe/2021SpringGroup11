from django.db import models

# Create your models here.
class SpamItem(models.Model):
  email = models.TextField()
  spam = models.BooleanField(default=False)
