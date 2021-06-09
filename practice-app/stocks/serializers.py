from rest_framework import serializers
from .models import StockCandle
from .models import StockQuote
from .models import Comment


class StockQuoteSerializer(serializers.ModelSerializer):
    class Meta:
        model = StockQuote
        fields = ['id', 'symbol', 'current', 'high', 'low']


class StockCandleSerializer(serializers.ModelSerializer):
    class Meta:
        model = StockCandle
        fields = ['id', 'symbol', 'resolution', 'open', 'high', 'low', 'close', 'time', 'volume']


class CommentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Comment
        fields = ['id', 'symbol', 'user', 'message', 'created']
