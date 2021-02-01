from django.conf.urls import url
from channels.auth import AuthMiddlewareStack
from channels.routing import ProtocolTypeRouter, URLRouter
from channelsmultiplexer import AsyncJsonWebsocketDemultiplexer
from backoffice.consumers import ObservationConsumer, CallLogConsumer, LegalObserverLogConsumer, ReportConsumer, ReleaseConsumer

application = ProtocolTypeRouter({
    # (http->django views is added by default)
    'websocket': AuthMiddlewareStack(
        URLRouter([
            url(r"^ws/$", AsyncJsonWebsocketDemultiplexer.as_asgi(
                observation = ObservationConsumer.as_asgi(),
                call_log = CallLogConsumer.as_asgi(),
                legal_observer_log = LegalObserverLogConsumer.as_asgi(),
                report = ReportConsumer.as_asgi(),
                release = ReleaseConsumer.as_asgi(),
            )),
        ]),
    ),
})