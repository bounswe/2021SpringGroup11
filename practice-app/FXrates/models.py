from django.db import models
from datetime import datetime

# Create your models here.

class Price(models.Model):
    pair=models.CharField(max_length=20)
    frame=models.CharField(max_length=20,default="M1")

    acq_time=models.IntegerField()
    source=models.CharField(max_length=50)

    data_time=models.IntegerField()
    open=models.FloatField(default=0.0)
    high=models.FloatField(default=0.0)
    low=models.FloatField(default=0.0)
    close=models.FloatField(default=0.0)
    def __str__(self):
        res='{"time":'+str(self.data_time)+',"price":'
        res+="[{:>.6f},{:>.6f},{:>.6f},{:>.6f}]".format(self.open,self.high,self.low,self.close)+"}"
        return res


class Comment(models.Model):
    pair=models.CharField(max_length=20)
    time=models.IntegerField('date published')
    user=models.CharField(max_length=50)
    message=models.CharField(max_length=1000)
    def __str__(self):
        #return "***COMMENT***\nPAIR: "+str(self.pair)+"\nUSER: "+str(self.user)+"\nTIME: "+str(self.time)+"\nMESSAGE: "+str(self.message)
        res='<div name="comment"><hr>'
        res+="<strong>Name:</strong> "+str(self.user)+"<br>"
        res+="<strong>Pair:</strong> "+str(self.pair)+"<br>" 
        res+="<strong>Time:</strong> "+str(datetime.utcfromtimestamp(self.time).strftime('%Y-%m-%d %H:%M:%S'))+"<br>"
        res+="<strong>Comment:</strong> <br>"
        res+="<p>"+str(self.message)+"</p><hr>"
        res+="</div>"
        return res
