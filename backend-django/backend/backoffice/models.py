from django.db import models
from django.contrib.auth.models import AbstractUser
from softdelete.models import SoftDeleteObject

class User(AbstractUser):
    pass

class Identity(SoftDeleteObject, models.Model):
    pass

class Observation(SoftDeleteObject, models.Model):
    createdAt = models.DateTimeField(auto_now_add=True)
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

class PleaHearing(SoftDeleteObject, models.Model):
    createdAt = models.DateTimeField(auto_now_add=True)
    identity = models.ForeignKey(Identity, on_delete=models.CASCADE)
    name = models.TextField()
    email = models.TextField()
    phone = models.TextField()
    hometown = models.TextField()
    charge = models.TextField()
    lawFirm = models.TextField()
    consentToContact = models.BooleanField()
    canShareWithLocalXRGroup = models.BooleanField()
    consentToRecord = models.BooleanField()
    consentToPress = models.BooleanField()

class StationRegion(SoftDeleteObject, models.Model):
    name = models.TextField()

    def __str__(self):
        return self.name

class Station(SoftDeleteObject, models.Model):
    createdAt = models.DateTimeField(auto_now_add=True)
    name = models.TextField()
    region = models.ForeignKey(StationRegion, on_delete=models.SET_NULL, null=True)
    verified = models.BooleanField()
    rejected = models.BooleanField()

    def __str__(self):
        descriptor = ""
        if not self.verified:
            descriptor = " (unverified)"
        if self.rejected:
            descriptor += " (rejected)"
        return "{}{}".format(self.name, descriptor)

class CallLog(SoftDeleteObject, models.Model):
    createdAt = models.DateTimeField(auto_now_add=True)
    comment = models.TextField()
    createdBy = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)

class LegalObserverLog(SoftDeleteObject, models.Model):
    createdAt = models.DateTimeField(auto_now_add=True)
    comment = models.TextField()
    createdBy = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)

class Report(SoftDeleteObject, models.Model):
    createdAt = models.DateTimeField(auto_now_add=True)
    station = models.ForeignKey(Station, on_delete=models.SET_NULL, null=True)
    arrestTime = models.DateTimeField()
    location = models.TextField()
    name = models.TextField()
    arrestingOfficerId = models.TextField()
    consentToContact = models.BooleanField()
    concernMentalDistress = models.BooleanField()
    concernPhysicalDistress = models.BooleanField()
    concernMinor = models.BooleanField()
    concernPoliceBehaviour = models.BooleanField()
    concernPolicePrejudice = models.BooleanField()
    concernMedicationNeed = models.BooleanField()
    medicationName = models.TextField()
    concernHandcuffs = models.BooleanField()
    observations = models.TextField()
    comment = models.TextField()
    witness = models.ForeignKey(Identity, on_delete=models.CASCADE)
    isHS2Action = models.BooleanField()

class Release(SoftDeleteObject, models.Model):
    createdAt = models.DateTimeField(auto_now_add=True)
    name = models.TextField()
    arrestTime = models.DateTimeField()
    location = models.TextField()
    offence = models.TextField()
    termsOfRelease = models.TextField()
    charges = models.TextField()
    bailConditions = models.TextField()
    courtDate = models.TextField()
    courtLocation = models.TextField()
    policeStation = models.ForeignKey(Station, on_delete=models.SET_NULL, null=True)
    localXRGroup = models.TextField()
    nearestCity = models.TextField()
    injuries = models.TextField()
    adverseEvents = models.TextField()
    heldMoreThan24Hours = models.BooleanField()
    helpNeeded = models.TextField()
    specialRequest = models.TextField()
    numberRebels = models.IntegerField()
    rebelsStillHeld = models.IntegerField()
    email = models.TextField()
    phone = models.TextField()
    canShareWithLocalXRGroup = models.BooleanField()
    canShareWithXRPress = models.BooleanField()
    comment = models.TextField()
    isHS2Action = models.BooleanField()
    isPartOfXR = models.BooleanField()
    identity = models.ForeignKey(Identity, on_delete=models.CASCADE, null=True)