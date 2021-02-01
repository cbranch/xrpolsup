from django.contrib.auth.models import Group
from rest_framework import serializers
from . import models

class UserSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = models.User
        fields = ['url', 'username', 'email', 'groups']

class GroupSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Group
        fields = ['url', 'name']

class ObservationSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Observation

class CallLogSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.CallLog

class LegalObserverLogSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.LegalObserverLog

class ReportSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Report

class ReleaseSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Release