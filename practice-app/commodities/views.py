from rest_framework.exceptions import ValidationError, ParseError
from rest_framework import status
from django.shortcuts import redirect, render
from rest_framework.views import APIView
import requests
from datetime import datetime
import json
import os
#from dotenv import load_dotenv
#load_dotenv()

# Create your views here.


# Dalian Commodities Exchange https://www.quandl.com/data/DCE-Dalian-Commodities-Exchange/documentation
DCE_CODES = ['BB', 'CS', 'JM', 'C', 'Y', 'EB', 'EG', 'I', 'PP', 'J']
DCE_NAMES = ['Blockboard', 'Corn Starch	', 'Coking Coal', 'Corn', 'Crude Soybean Oil', 'Ethenyl Benzene', 'Ethylene Glycol', 'Iron Ore', 'Polypropylene', 'Metallurgical Coke']
DCE_DATABASE_CODE = 'DCE'
MONTH_CODES = ['F', 'G', 'H', 'J', 'K', 'M', 'N', 'Q', 'U', 'V', 'X', 'Z']
#quandl_api_key = os.environ.get('QUANDL_API_KEY')
quandl_api_key = os.environ["QUANDL_API_KEY"]
# ['2015-05-15', None, None, None, 2398.0, 2494.0, 2398.0, 0.0, 0.0, 0.0]
class DCE(APIView):
    def post(self, request):
        data = (
            request.data if isinstance(
                request.data, dict) else json.loads(request.body)
        )
        if not data.get('code') or not data.get('start') or not data.get('end'):
            return ParseError('Missing data')
        
        code = data['code']
        start = data['start']
        end = data['end']
        try: 
            start_year = int(start)
            end_year = int(end)
        except:
            return ValidationError('Years must be integer')

        if start_year > end_year:
            return ValidationError('Start year cannot be greater than end year')

        data = []
        for year  in range(start_year, end_year + 1):
            r = requests.get('https://www.quandl.com/api/v3/datasets/{}/{}{}{}?api_key={}'.format(DCE_DATABASE_CODE, code, MONTH_CODES[0], year, quandl_api_key))
            #print('https://www.quandl.com/api/v3/datasets/{}/{}{}{}?api_key={}'.format(DCE_DATABASE_CODE, code, MONTH_CODES[0], year, quandl_api_key))
            if not r.json().get('dataset'):
                continue
            cur_data = r.json().get('dataset').get('data')
            data = data + cur_data
            
        final = []
        # column_names': ['Date', 'Open', 'High', 'Low', 'Close', 'Pre Settle', 'Settle', 'Volume', 'Open Interest', 'Turnover']    
        for i in range(0, len(data)):
            if data[i][0] and data[i][1] and data[i][2] and data[i][3] and data[i][4]:
                final.append(datetime.strptime(data[i][0],
                           '%Y-%m-%d').timestamp()*1000)
                final.append(data[i][1])
                final.append(data[i][2])
                final.append(data[i][3])
                final.append(data[i][4])

        if len(final) == 0:
            return redirect('home')

        for i in range(len(DCE_CODES)):
            if DCE_CODES[i] == code:
                name = DCE_NAMES[i]
                break

        return render(request, 'data.html', {'dps': final, 'name': name})
        

class Home(APIView):
    def get(self, request):
        x = {}
        for i in range(0, len(DCE_NAMES)):
            x[DCE_CODES[i]] = DCE_NAMES[i]
        #print("Aaaaa")
        #print(x)
        return render(request, 'homepage.html', {'data': x})