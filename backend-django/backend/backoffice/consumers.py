from . import models, serializers
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

class ObservationConsumer(ListModelMixin, ObserverModelInstanceMixin, GenericAsyncAPIConsumer):
    queryset = models.Observation.objects.all()
    serializer_class = serializers.ObservationSerializer
    permission_classes = (permissions.IsAuthenticated,)

class CallLogConsumer(ListModelMixin, ObserverModelInstanceMixin, GenericAsyncAPIConsumer):
    queryset = models.CallLog.objects.all()
    serializer_class = serializers.CallLogSerializer
    permission_classes = (permissions.IsAuthenticated,)

class LegalObserverLogConsumer(ListModelMixin, ObserverModelInstanceMixin, GenericAsyncAPIConsumer):
    queryset = models.LegalObserverLog.objects.all()
    serializer_class = serializers.LegalObserverLogSerializer
    permission_classes = (permissions.IsAuthenticated,)

class ReportConsumer(ListModelMixin, ObserverModelInstanceMixin, GenericAsyncAPIConsumer):
    queryset = models.Report.objects.all()
    serializer_class = serializers.ReportSerializer
    permission_classes = (permissions.IsAuthenticated,)

class ReleaseConsumer(ListModelMixin, ObserverModelInstanceMixin, GenericAsyncAPIConsumer):
    queryset = models.Release.objects.all()
    serializer_class = serializers.ReleaseSerializer
    permission_classes = (permissions.IsAuthenticated,)