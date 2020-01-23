from django.urls import path

from . import views

urlpatterns = [
    path('', views.index, name='index'),
    path('trial_observation', views.observation, name='observation'),
    path('plea_hearing', views.plea_hearing, name='plea_hearing'),
]