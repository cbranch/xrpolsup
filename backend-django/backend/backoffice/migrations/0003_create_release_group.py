# Generated by Django 3.1.5 on 2021-01-31 23:34

from django.db import models, migrations
from django.apps import apps
from django.contrib.contenttypes.models import ContentType
from django.contrib.auth.models import Group, Permission
from backoffice.models import Release

def apply_migration(apps, schema_editor):
    g = Group.objects.create(name=u'Release Editor')
    release_ct = ContentType.objects.get_for_model(Release)
    release_perms = Permission.objects.filter(content_type=release_ct)
    g.permissions.set(release_perms)

def revert_migration(apps, schema_editor):
    Group.objects.get(name=u'Release Editor').delete()

class Migration(migrations.Migration):

    dependencies = [
        ('backoffice', '0002_station_list'),
    ]

    operations = [
        migrations.RunPython(apply_migration, revert_migration)
    ]
