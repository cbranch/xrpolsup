from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import User, Observation, PleaHearing, StationRegion, Station, CallLog, LegalObserverLog, Report, Release

admin.site.register(User, UserAdmin)
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
admin.site.register(CallLog)
admin.site.register(LegalObserverLog)
admin.site.register(Report)
admin.site.register(Release)