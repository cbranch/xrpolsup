from django.contrib import admin
from .models import Observation, PleaHearing, StationRegion, Station

admin.site.register(Observation)
admin.site.register(PleaHearing)

class StationInline(admin.TabularInline):
    model = Station

class StationRegionAdmin(admin.ModelAdmin):
    inlines = [
        StationInline,
    ]

admin.site.register(StationRegion, StationRegionAdmin)
admin.site.register(Station)