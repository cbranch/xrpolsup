import json
from django.shortcuts import render
from django.http import JsonResponse, HttpResponseNotAllowed
from django.views.decorators.csrf import csrf_exempt
import django.utils.timezone

from .models import Observation, Identity

def index(request):
    return render(request, 'backoffice/index.html', {})

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
