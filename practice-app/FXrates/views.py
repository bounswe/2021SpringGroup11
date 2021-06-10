from django.shortcuts import render
from FXrates.models import Price, Comment
from django.views.decorators.csrf import csrf_exempt
import json
from datetime import datetime as dt

# Create your views here.

from django.http import HttpResponse




def index(request):
    f=open("FXrates/frontend.html","r")
    content=f.read()
    f.close()
    return HttpResponse(content)

def api(request,pair,freq,begin,till):
    q=Price.objects.filter(pair=pair,frame=freq,data_time__gte=begin,data_time__lte=till)
    res=list()
    for i in q:
        res.append(str(i))
    x=",".join(res)
    return HttpResponse("["+x+"]")

    
@csrf_exempt
def postcomment(request):
    #print(request.body)
    data=json.loads(request.body.decode("utf-8"))
    prev=Comment.objects.filter(pair=data["pair"],user=data["name"],message=data["message"])
    if(len(prev)>0):
        return HttpResponse(status=406)#avoid re-sending comments
    c=Comment(pair=data["pair"],time=int(dt.timestamp(dt.now())),user=data["name"],message=data["message"])
    c.save()
    print(c)
    return HttpResponse("success")
    
def getcomments(request):
    q=Comment.objects.all()
    res=""
    for i in q:
        res+=str(i)
    return HttpResponse(res)
    
