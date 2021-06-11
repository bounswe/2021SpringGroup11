from django.shortcuts import render
from django.http import HttpResponse
from django.template import loader
from django.shortcuts import render
from urllib.parse import urlparse
import requests
from rest_framework.response import Response
from rest_framework import status
from rest_framework.decorators import api_view
from django.http import HttpResponseNotFound
from django.http import HttpResponseBadRequest
from logosearch.models import Logos
from logosearch.serializer import LogosSerializer


@api_view(['GET'])
def index(request):
    urll = request.GET.get("Site")
    if(urll):
        parsed = urlparse(urll)
        if(parsed.netloc == ''):
            siteurl= urll
        else:
            siteurl= parsed.netloc
        obj = Logos.objects.filter(site_url=siteurl)
        if(obj):
            logodict = LogosSerializer(obj[0])
            logo={"site":siteurl,"image":logodict.data['photo_url']}
            return render(request, 'logosearch/main.html',logo)
        else:
            concaturl='http://logo.clearbit.com/'+siteurl
            res = requests.get(concaturl)
            logo={"site":siteurl,"image":concaturl}
            if(res.status_code==200):
                return render(request, 'logosearch/main.html',logo)
            else:
                dictionary={"exp":"Cannot found the logo, please check the url or suggest a logo for the site."}
                return HttpResponseNotFound("Cannot found the logo, please check the url or suggest a logo for the site.")  
    else:
        return render(request, 'logosearch/main.html')


@api_view(['GET'])
def apindex(request):
    urll = request.GET.get("Site")
    if(urll):
        parsed = urlparse(urll)
        if(parsed.netloc == ''):
            siteurl= urll
        else:
            siteurl= parsed.netloc
        obj = Logos.objects.filter(site_url=siteurl)
        if(obj):
            logodict = LogosSerializer(obj[0])
            logo={"site":siteurl,"image":logodict.data['photo_url']}
            resp=Response(logo,status=status.HTTP_200_OK)
            return resp
        else:
            concaturl='http://logo.clearbit.com/'+siteurl
            res = requests.get(concaturl)
            logo={"site":siteurl,"image":concaturl}
            if(res.status_code==200):
                resp=Response(logo,status=status.HTTP_200_OK)
                return resp
            else:
                dictionary={"exp":"Cannot found the logo, please check the url or suggest a logo for the site."}
                resp=Response(dictionary,status=status.HTTP_404_NOT_FOUND)
                return resp

    else:
        dictionary={"exp":"Please give a URL as parameter."}
        resp=Response(dictionary,status=status.HTTP_400_BAD_REQUEST)
        return resp

@api_view(['GET', 'POST'])
def routeNew(request):
    if(request.method=='GET'):
        return render(request, 'logosearch/suggest.html')
    else:
        urll = request.POST.get("Site")
        image = request.POST.get("Image")
        if(urll and image):
            dictionary={}
            parsed = urlparse(urll)
            if(parsed.netloc == ''):
                siteurl= urll
            else:
                siteurl= parsed.netloc
            if(image.endswith(('.jpg','.jpeg','.png'))):
                obj,created = Logos.objects.update_or_create(site_url=siteurl,photo_url=image,defaults={'photo_url':image})
                serializedobj = LogosSerializer(obj)
                dictionary = {"exp":"Logo added.","site":serializedobj.data['site_url'],"image":serializedobj.data['photo_url']}
            else:
                return HttpResponseBadRequest("Enter Valid Image URL.")
                
        return render(request, 'logosearch/suggest.html',dictionary)


@api_view(['POST'])
def apiRouteNew(request):
    urll = request.POST.get("Site")
    image = request.POST.get("Image")
    print(urll)
    print(image)
    if(urll and image):
        parsed = urlparse(urll)
        if(parsed.netloc == ''):
            siteurl= urll
        else:
            siteurl= parsed.netloc
        if(len(siteurl)>100):
            dictionary={"exp":"Site URL is too long."}
            resp=Response(dictionary,status=status.HTTP_400_BAD_REQUEST)
            return resp
        if(image.endswith(('.jpg','.jpeg','.png'))):
            obj,created = Logos.objects.update_or_create(site_url=siteurl,photo_url=image,defaults={'photo_url':image})
            serializedobj = LogosSerializer(obj)
            dictionary = {"exp":"Logo added.","site":serializedobj.data['site_url'],"image":serializedobj.data['photo_url']}
            resp=Response(dictionary,status=status.HTTP_200_OK)
            return resp
        else:
            dictionary={"exp":"Enter Valid Image URL"}
            resp=Response(dictionary,status=status.HTTP_400_BAD_REQUEST)
            return resp
    else:
        dictionary={"exp":"Missing Parameters"}
        resp=Response(dictionary,status=status.HTTP_400_BAD_REQUEST)
        return resp
            
