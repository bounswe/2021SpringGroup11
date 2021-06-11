import requests
from django.http.request import HttpRequest
from django.shortcuts import render
from .models import Sector
from .models import MailAddress
from django.http import HttpResponse
import json
import ssl
import urllib
ssl._create_default_https_context = ssl._create_unverified_context


def ETFSector(request: HttpRequest):
    entered_symbol=''
    if request.method == "GET" and "entered_symbol" in request.GET:
        entered_symbol=request.GET["entered_symbol"]
        url = "https://finnhub.io/api/v1/etf/sector?symbol=" + entered_symbol + "&token=c2v6ki2ad3i9mrpv0p7g"
        req = urllib.request.Request(url)
        response = urllib.request.urlopen(req)

        page = response.read().decode("utf8")
        data = json.loads(json.loads(json.dumps(page)))
    elif request.method == "POST" and "mail_address" in request.POST:
        mail_address=request.POST["mail_address"]
        m = MailAddress(mail=mail_address)
        m.save()
        return HttpResponse("'" + mail_address + "'" + ' is added to the subscription list successfully!')
    else:
        return render(request, 'ETFSector.html')

    if data == {'sectorExposure': [], 'symbol': ''}:
        context = ["This is not a valid symbol, check and try again."]
    else:
        context = []
        for i in range(10):
            exposure = data['sectorExposure'][i]['exposure']
            industry = data['sectorExposure'][i]['industry']
            context += ['exposure:' + str(exposure) + '        --        industry: ' + str(industry)]
            s = Sector(symbol=entered_symbol, exposure=exposure, industry=industry)
            s.save()

    return render(request, 'ETFSector.html', {'context': context})
