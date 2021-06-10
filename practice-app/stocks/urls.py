from django.urls import path
from . import views
from rest_framework.urlpatterns import format_suffix_patterns

urlpatterns = [
    path('', views.StockList.as_view()),
    path('<str:symbol>/<str:res>/<str:fromm>/<str:to>', views.StockDetail.as_view()),
    path('comments/<str:symbol>', views.StockComment.as_view()),
    path('home/', views.home),
]

urlpatterns = format_suffix_patterns(urlpatterns)
