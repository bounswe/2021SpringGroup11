from django.urls import path
from . import views
from rest_framework.urlpatterns import format_suffix_patterns

urlpatterns = [
    path('stocks/', views.StockList.as_view()),
    path('stocks/<str:symbol>/<str:res>/<str:fromm>/<str:to>', views.StockDetail.as_view()),
    path('comments/<str:symbol>', views.StockComment.as_view()),
]

urlpatterns = format_suffix_patterns(urlpatterns)
