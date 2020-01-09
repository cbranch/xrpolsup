from asgiref.sync import async_to_sync
from channels.generic.websocket import WebsocketConsumer
import json

class ObservationConsumer(WebsocketConsumer):
    GROUP_NAME='observation'

    def connect(self):
        async_to_sync(self.channel_layer.group_add)(self.GROUP_NAME, self.channel_name)
        self.accept()

    def disconnect(self, close_code):
        async_to_sync(self.channel_layer.group_discard)(self.GROUP_NAME, self.channel_name)

    def receive(self, text_data):
        text_data_json = json.loads(text_data)
        action = text_data_json['action']

        if action == "add":
            id = text_data_json['id']
            async_to_sync(self.channel_layer.group_send)(
                self.GROUP_NAME,
                {
                    'type': 'observation_added',
                    'id': id
                }
            )

    def observation_added(self, event):
        id = event['id']

        self.send(text_data=json.dumps({
            'event': 'added',
            'id': id
        }))

    def observation_updated(self, event):
        id = event['id']

        self.send(text_data=json.dumps({
            'event': 'updated',
            'id': id
        }))

    def observation_deleted(self, event):
        id = event['id']

        self.send(text_data=json.dumps({
            'event': 'deleted',
            'id': id
        }))