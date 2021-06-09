import time

from .models import StockQuote
from .models import StockCandle
from .models import Comment

from .serializers import StockCandleSerializer
from .serializers import StockQuoteSerializer
from .serializers import CommentSerializer

from rest_framework import generics
from django.http import Http404
from rest_framework.views import APIView
from rest_framework.response import Response
import requests
from rest_framework import status

apitoken = "c2tqj12ad3icl6gedmag"
symbols = ['AAPL', 'MSFT', 'GOOG', 'GOOGL', 'AMZN', 'FB', 'TSLA', 'BABA']


class StockList(APIView):

    def get(self, request, format=None):
        for sym in symbols:
            response = requests.get(
                'https://finnhub.io/api/v1/quote?symbol=' + sym + '&token=' + apitoken)
            data = response.json()
            try:
                stock = StockQuote.objects.get(symbol=sym)
                stock.data = data
            except:
                stock = StockQuote(symbol=sym, data=data)
            stock.save()
        stocks = StockQuote.objects.all()
        serializer = StockQuoteSerializer(stocks, many=True)
        return Response(serializer.data)


class StockDetail(APIView):
    def get(self, request, symbol, res, fromm, to, format=None):
        stocks = StockCandle.objects.filter(symbol=symbol, resolution=res, time__gte=fromm, time__lte=to)
        serializer = StockCandleSerializer(stocks, many=True)
        return Response(serializer.data)


class StockComment(APIView):
    def get(self, request, symbol):
        comments = Comment.objects.filter(symbol=symbol)
        serializer = CommentSerializer(comments, many=True)
        return Response(serializer.data)

    def post(self, request, symbol):
        serializer = CommentSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
