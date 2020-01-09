from django.db import models
from channels.layers import get_channel_layer
from asgiref.sync import async_to_sync

class Identity(models.Model):
    pass

class Observation(models.Model):
    createdAt = models.DateTimeField(auto_now_add=True)
    validTo = models.DateTimeField(null=True)
    identity = models.ForeignKey(Identity, on_delete=models.CASCADE)
    court = models.TextField()
    date = models.DateTimeField()
    bench = models.TextField()
    defendantName = models.TextField()
    defendantNumber = models.TextField()
    charges = models.TextField()
    representation = models.TextField()
    outline = models.TextField()
    evidenceSubmitted = models.TextField()
    evidenceInPerson = models.TextField()
    verdict = models.TextField()
    sentence = models.TextField()
    costs = models.TextField()
    notes = models.TextField()

    def save(self, *args, **kwargs):
        id = self.id
        super().save(*args, **kwargs)
        channel_layer = get_channel_layer()
        if id:
            async_to_sync(channel_layer.group_send)('observation', {'type': 'observation_updated', 'id': id})
        else:
            async_to_sync(channel_layer.group_send)('observation', {'type': 'observation_added', 'id': self.id})

    def delete(self, *args, **kwargs):
        id = self.id
        super().delete(*args, **kwargs)
        channel_layer = get_channel_layer()
        async_to_sync(channel_layer.group_send)('observation', {'type': 'observation_deleted', 'id': id})