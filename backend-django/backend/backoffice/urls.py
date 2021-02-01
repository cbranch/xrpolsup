from django.urls import include, path
from django.contrib import admin
from rest_framework import routers

from . import views

router = routers.DefaultRouter()
router.register(r'users', views.UserViewSet)
router.register(r'groups', views.GroupViewSet)

urlpatterns = [
    path('', include(router.urls)),
    path('api-auth/', include('rest_framework.urls', namespace='rest_framework')),
    path('accounts/', include('django.contrib.auth.urls')),
    path('stations', views.stations, name='stations'),
    path('station_regions', views.station_regions, name='station_regions'),
    path('trial_observation', views.observation, name='observation'),
    path('plea_hearing', views.plea_hearing, name='plea_hearing'),
]