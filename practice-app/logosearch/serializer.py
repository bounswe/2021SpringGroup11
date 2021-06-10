from rest_framework import serializers
from logosearch.models import Logos

class LogosSerializer(serializers.ModelSerializer):
    class Meta:
        model= Logos
        fields=['id','site_url','photo_url']