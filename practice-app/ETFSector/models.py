from django.db import models


class Sector(models.Model):
    symbol = models.CharField(max_length=10)
    exposure = models.FloatField()
    industry = models.CharField(max_length=50)

    class Meta:
        ordering = ['symbol']

    def __str__(self):
        return "Symbol: "+str(self.symbol)+"\nExposure: "+str(self.exposure)+"\nIndustry: "+str(self.industry)


class MailAddress(models.Model):
    mail = models.CharField(max_length=100)

    class Meta:
        ordering = ['mail']

    def __str__(self):
        return "Mail address: "+str(self.mail)