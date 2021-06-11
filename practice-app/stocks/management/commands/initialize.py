from django.core.management.base import BaseCommand
from ...models import StockCandle
import time
import requests

apitoken = "c2tqj12ad3icl6gedmag"


class Command(BaseCommand):
    help = "Updates the database from source"

    def add_arguments(self, parser):
        parser.add_argument("days_before_now", type=int)

    def handle(self, *args, **kwargs):
        symbols = ['AAPL', 'MSFT', 'GOOG', 'GOOGL', 'AMZN', 'FB', 'TSLA', 'BABA']
        resolutions = ["5", "15", "30", "60", "D", "W", "M"]
        start_time = str(int(time.time()) - 3600 * 24 * kwargs['days_before_now'])
        for sym in symbols:
            for res in resolutions:
                uri = "https://finnhub.io/api/v1//stock/candle?symbol=" + sym + "&resolution=" + res + "&from=" + start_time + "&to=" + str(
                    int(time.time())) + "&token=" + apitoken
                resp = requests.get(uri).json()
                close = resp['c']
                high = resp['h']
                low = resp['l']
                open = resp['o']
                timestamp = resp['t']
                volume = resp['v']
                for i in range(len(timestamp)):
                    stock = StockCandle(
                        symbol=sym, resolution=res, close=close[i], open=open[i], high=high[i], low=low[i], time=timestamp[i], volume=volume[i])
                    stock.save()
