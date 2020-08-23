from django.urls import path
from django.contrib import admin

from . import views

urlpatterns = [
    path('', views.index, name='index'),
    path('stations', views.stations, name='stations'),
    path('trial_observation', views.observation, name='observation'),
    path('plea_hearing', views.plea_hearing, name='plea_hearing'),
]