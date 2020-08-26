import json
from django.shortcuts import render
from django.http import JsonResponse, HttpResponseNotAllowed
from django.views.decorators.csrf import csrf_exempt
import django.utils.timezone

from .models import Observation, Identity, PleaHearing, Station

def index(request):
    return render(request, 'backoffice/index.html', {})

def stations(request):
    stations = Station.objects.exclude(verified=False, rejected=True)
    response = {"stations": [station.name for station in stations]}
    return JsonResponse(response)

def station_regions(request):
    stations = Station.objects.exclude(verified=False, rejected=True)
    regions = {}
    for station in stations:
        regions.setdefault(station.region.name, []).append(station.name)
    response = {"regions": regions}
    return JsonResponse(response)

@csrf_exempt
def observation(request):
    if request.method != 'POST':
        return HttpResponseNotAllowed(['POST'])

    body = json.loads(request.body)

    identity = Identity()
    identity.save()

    ob = Observation()
    ob.identity = identity
    ob.court = body.get('court', '')
    ob.date = body.get('date', django.utils.timezone.now())
    ob.bench = body.get('bench', '')
    ob.defendantName = body.get('defendantName', '')
    ob.defendantNumber = body.get('defendantNumber', '')
    ob.charges = body.get('charges', '')
    ob.representation = body.get('representation', '')
    ob.outline = body.get('outline', '')
    ob.evidenceSubmitted = body.get('evidenceSubmitted', '')
    ob.evidenceInPerson = body.get('evidenceInPerson', '')
    ob.verdict = body.get('verdict', '')
    ob.sentence = body.get('sentence', '')
    ob.costs = body.get('costs', '')
    ob.notes = body.get('notes', '')
    ob.save()

    return JsonResponse({})

@csrf_exempt
def plea_hearing(request):
    if request.method != 'POST':
        return HttpResponseNotAllowed(['POST'])

    body = json.loads(request.body)

    identity = Identity()
    identity.save()

    ph = PleaHearing()
    ph.identity = identity
    ph.name = body.get('name', '')
    ph.email = body.get('email', '')
    ph.phone = body.get('phone', '')
    ph.hometown = body.get('hometown', '')
    ph.charge = body.get('charge', '')
    ph.lawFirm = body.get('lawFirm', '')
    ph.consentToContact = body.get('consentToContact', False)
    ph.canShareWithLocalXRGroup = body.get('canShareWithLocalXRGroup', False)
    ph.consentToRecord = body.get('consentToRecord', False)
    ph.consentToPress = body.get('consentToPress', False)
    ph.save()

    return JsonResponse({})
