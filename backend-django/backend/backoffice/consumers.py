from . import models
from rest_framework import serializers
from djangochannelsrestframework import permissions
from djangochannelsrestframework.generics import GenericAsyncAPIConsumer
from djangochannelsrestframework.mixins import (
    ListModelMixin,
    PatchModelMixin,
    UpdateModelMixin,
    CreateModelMixin,
    DeleteModelMixin,
)
from djangochannelsrestframework.observer.generics import ObserverModelInstanceMixin

class ObservationSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Observation

class ObservationConsumer(ListModelMixin, ObserverModelInstanceMixin, GenericAsyncAPIConsumer):
    queryset = models.Observation.objects.all()
    serializer_class = ObservationSerializer
    permission_classes = (permissions.IsAuthenticated,)