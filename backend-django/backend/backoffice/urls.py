from django.urls import include, path
from django.contrib import admin

from . import views

urlpatterns = [
    path('', views.index, name='index'),
    path('accounts/', include('django.contrib.auth.urls')),
    path('stations', views.stations, name='stations'),
    path('station_regions', views.station_regions, name='station_regions'),
    path('trial_observation', views.observation, name='observation'),
    path('plea_hearing', views.plea_hearing, name='plea_hearing'),
]