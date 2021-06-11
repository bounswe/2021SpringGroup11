from django.shortcuts import render
from django.http import HttpResponseRedirect, HttpResponse
from .models import SpamItem
from django.http import JsonResponse
from django.core.serializers import serialize
first_time = True
import json


import http.client
import mimetypes
conn = http.client.HTTPSConnection("api.eva.pingutil.com")
payload = ''
headers = {}

# JSON responses are include "status" field and other field according to status
# status = "Success" | "Error"
# when status is "Success"

def getData(email):
  conn.request("GET", "/email?email="+email, payload, headers)
  res = conn.getresponse()
  data = res.read().decode()
  print(data)
  return (data)

def index(request):
  return render(request, "spam.html")


# Create your views here.
def getList(request):
  all_todo_items = SpamItem.objects.all()
  # print(all_todo_items)

  data = serialize("json", all_todo_items)

  return JsonResponse({"items":json.loads(data)},safe=False)

def addItem(request):
  dd=(json.loads(request.body.decode("utf-8")))
  print(dd)
  dd=dd["email"]
  data = json.loads( getData(dd))

  new_item = SpamItem(email =dd ,spam=data["data"]["spam"])
  new_item.save()
  return JsonResponse({"status":"success"},safe=False)

def deleteItem(request, item_id):
  item_to_delete = SpamItem.objects.get(id=item_id)
  item_to_delete.delete()
  return HttpResponseRedirect('/spam')
