from django.db import models

# Create your models here.
class Logos(models.Model):
    site_url = models.CharField(max_length=100)
    photo_url = models.TextField()

    
