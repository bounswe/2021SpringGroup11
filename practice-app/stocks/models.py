from django.db import models


class StockQuote(models.Model):
    created = models.DateTimeField(auto_now_add=True)
    symbol = models.CharField(max_length=50, blank=True, default='', unique=True)
    current = models.FloatField(default=0.0)
    high = models.FloatField(default=0.0)
    low = models.FloatField(default=0.0)

    class Meta:
        ordering = ['created']


class StockCandle(models.Model):
    created = models.DateTimeField(auto_now_add=True)
    symbol = models.CharField(max_length=50, blank=True, default='')
    resolution = models.CharField(max_length=10, default=1)
    close = models.FloatField(default=0.0)
    high = models.FloatField(default=0.0)
    low = models.FloatField(default=0.0)
    open = models.FloatField(default=0.0)
    time = models.IntegerField(default=0)
    volume = models.IntegerField(default=0.0)

    class Meta:
        ordering = ['time']


class Comment(models.Model):
    created = models.DateTimeField(auto_now_add=True)
    symbol = models.CharField(max_length=50)
    user = models.CharField(max_length=100)
    message = models.CharField(max_length=1000)

    class Meta:
        ordering = ['created']
