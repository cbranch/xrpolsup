from datetime import datetime
import json
from django.contrib.auth.models import Group
from django.shortcuts import render
from django.http import JsonResponse, HttpResponseNotAllowed
from django.views.decorators.csrf import csrf_exempt
import django.utils.timezone
from rest_framework import viewsets
from rest_framework import permissions

from .models import User, Observation, Identity, PleaHearing, Station, CallLog, LegalObserverLog, Report, Release
from . import serializers


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


def make_datetime(str_date, str_time):
    dt = "%s %s" % (str_date, str_time)
    return datetime.strptime(dt, "%Y-%m-%d %H:%M")


def get_or_add_station(station_name):
    try:
        station = Station.objects.get(name=station_name)
    except Station.DoesNotExist:
        station = Station(name=station_name, verified=False, rejected=False)
        station.save()


@csrf_exempt
def arrestee_report(request):
    if request.method != 'POST':
        return HttpResponseNotAllowed(['POST'])

    body = json.loads(request.body)

    identity = Identity()
    identity.save()

    expected_keys = {
        "name": '',
        "location": '',
        "offence": '',
        "termsOfRelease": '',
        "charges": '',
        "bailConditions": '',
        "courtDate": '',
        "courtLocation": '',
        "localXRGroup": '',
        "nearestCity": '',
        "adverseEvents": '',
        "heldMoreThan24Hours": False,
        "helpNeeded": '',
        "specialRequest": '',
        "numberRebels": 0,
        "rebelsStillHeld": 0,
        "canShareWithLocalXRGroup": False,
        "canShareWithXRPress": False,
        "isHS2Action": False,
        "isPartOfXR": False,
    }
    report_vals = {k: body.get(k) or expected_keys[k] for k in expected_keys}
    report_vals["arrestTime"] = make_datetime(body['date'], body['time'])
    report_vals["policeStation"] = get_or_add_station(body["policeStation"])
    report_vals["injuries"] = body.get('anyInjuries') or ''
    report_vals["identity"] = identity
    report_vals["email"] = body.get('contactByEmail') or ''
    report_vals["phone"] = body.get('contactByPhone') or ''

    r = Release(**report_vals)
    r.save()

    return JsonResponse({})


@csrf_exempt
def station_report(request):
    if request.method != 'POST':
        return HttpResponseNotAllowed(['POST'])

    body = json.loads(request.body)

    identity = Identity()
    identity.save()

    station = get_or_add_station(body['stationName'])
    is_hs2 = body.get('isHS2Action', False)
    witness_email = body.get('witnessEmail') or ''

    for a in body['arrestees']:
        report_vals = {
            "station": station,
            "arrestTime": make_datetime(a['date'], a['time']),
            "location": a.get('location') or '',
            "name": a.get('name') or '',
            "arrestingOfficerId": a.get('arrestingOfficerId') or '',
            "concernMentalDistress": "mentalDistress" in a['concerns'],
            "concernPhysicalDistress": "physicalDistress" in a['concerns'],
            "concernMinor": "minor" in a['concerns'],
            "concernPoliceBehaviour": "policeBehaviour" in a['concerns'],
            "concernPolicePrejudice": "policePrejudice" in a['concerns'],
            "concernMedicationNeed": "medicationNeed" in a['concerns'],
            "medicationName": a.get('medicationName') or '',
            "concernHandcuffs": "handcuffs" in a['concerns'],
            "observations": a.get('observations') or '',
            "comment": a.get('comment') or '',
            "isHS2Action": is_hs2,
            "witness": identity,
        }
        r = Report(**report_vals)
        r.save()

    return JsonResponse({})


class UserViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows users to be viewed or edited.
    """
    queryset = User.objects.all().order_by('-date_joined')
    serializer_class = serializers.UserSerializer
    permission_classes = [permissions.IsAdminUser]


class GroupViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows groups to be viewed or edited.
    """
    queryset = Group.objects.all()
    serializer_class = serializers.GroupSerializer
    permission_classes = [permissions.IsAdminUser]


class CallLogViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows groups to be viewed or edited.
    """
    queryset = CallLog.objects.all()
    serializer_class = serializers.CallLogSerializer
    permission_classes = [permissions.DjangoModelPermissions]


class LegalObserverLogViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows groups to be viewed or edited.
    """
    queryset = LegalObserverLog.objects.all()
    serializer_class = serializers.LegalObserverLogSerializer
    permission_classes = [permissions.DjangoModelPermissions]


class ReportViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows groups to be viewed or edited.
    """
    queryset = Report.objects.all()
    serializer_class = serializers.ReportSerializer
    permission_classes = [permissions.DjangoModelPermissions]


class ReleaseViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows groups to be viewed or edited.
    """
    queryset = Release.objects.all()
    serializer_class = serializers.ReleaseSerializer
    permission_classes = [permissions.DjangoModelPermissions]
