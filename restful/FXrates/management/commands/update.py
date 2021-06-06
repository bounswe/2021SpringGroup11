from django.core.management.base import BaseCommand, CommandError
from FXrates.models import Price as FX
import time
import requests
from datetime import datetime

apitoken="c2tqj12ad3icl6gedmag"

class Command(BaseCommand):
    help="Updates the database from source"

    def add_arguments(self,parser):
        parser.add_argument("hours_before_now",type=int)

    def handle(self, *args, **kwargs):
        commands=list()
        symbols=["EUR_USD","GBP_USD","USD_JPY","USD_TRY"]
        resolutions=["1","5","15","60"]
        start_time=str(int(time.time())-3600*kwargs['hours_before_now'])
        for sym in symbols:
            for res in resolutions:
                uri="https://finnhub.io/api/v1/forex/candle?symbol=OANDA:"+sym+"&resolution="+res+"&from="+start_time+"&to="+str(int(time.time()))+"&token="+apitoken
                resp=requests.get(uri).json()
                open=resp['o']
                high=resp['h']
                low=resp['l']
                close=resp['c']
                timestamp=resp['t']
                for i in range(len(timestamp)):
                    f=FX(pair=sym,frame=res,acq_time=int(time.time()),source="Finnhub.io",data_time=timestamp[i],open=open[i],high=high[i],low=low[i],close=close[i])
                    f.save()
