from django.urls import path
from .views import addItem, getList, deleteItem, index

urlpatterns = [
    path('', index),
    path('getList/', getList),
    path('addItem/', addItem),
    path('deleteItem/<int:item_id>/', deleteItem),
]