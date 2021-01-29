from django.conf.urls import url
from channels.auth import AuthMiddlewareStack
from channels.routing import ProtocolTypeRouter, URLRouter
from channelsmultiplexer import AsyncJsonWebsocketDemultiplexer
from backoffice.consumers import ObservationConsumer

application = ProtocolTypeRouter({
    # (http->django views is added by default)
    'websocket': AuthMiddlewareStack(
        URLRouter([
            url(r"^ws/$", AsyncJsonWebsocketDemultiplexer.as_asgi(
                observation = ObservationConsumer.as_asgi(),
            )),
        ]),
    ),
})