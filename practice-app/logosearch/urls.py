from django.urls import path

from . import views

urlpatterns = [
    path('', views.index, name='index'),
    path('suggest', views.routeNew, name='matter'),
    path('api/', views.apindex, name='apindex'),
    path('api/suggest/', views.apiRouteNew, name='apimatter'),

]