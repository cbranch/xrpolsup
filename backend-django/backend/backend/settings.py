"""
Django settings for backend project.

Generated by 'django-admin startproject' using Django 3.0.2.

For more information on this file, see
https://docs.djangoproject.com/en/3.0/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/3.0/ref/settings/
"""

import os

# Build paths inside the project like this: os.path.join(BASE_DIR, ...)
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

SECRET_KEY = 'u*8xr6ag!*v-&ewjvgc3)z#9jsfb-er!s!5uh@f9$748y#**zz'
DEBUG = True
ALLOWED_HOSTS = []

if 'BACKOFFICE_SECRET_KEY' in os.environ:
    SECRET_KEY = os.environ['BACKOFFICE_SECRET_KEY']
    DEBUG = False
    BASE_HOSTNAME = os.environ.get('BASE_HOSTNAME', 'arrestwatch.info')
    ALLOWED_HOSTS = [BASE_HOSTNAME, 'backoffice.%s' % BASE_HOSTNAME]


# Application definition

INSTALLED_APPS = [
    'channels',
    'backoffice',
    'softdelete',
    'rest_framework',
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
]

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'backend.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'backend.wsgi.application'

AUTH_USER_MODEL = "backoffice.User"

# Database
# https://docs.djangoproject.com/en/3.0/ref/settings/#databases

DEFAULT_DATABASE = {
    'ENGINE': 'django.db.backends.sqlite3',
    'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
}

if 'BACKOFFICE_DB_ENGINE' in os.environ:
    DEFAULT_DATABASE = {
        'ENGINE': os.environ.get('BACKOFFICE_DB_ENGINE', ''),
        'NAME': os.environ.get('BACKOFFICE_DB_NAME', ''),
        'USER': os.environ.get('BACKOFFICE_DB_USER', ''),
        'PASSWORD': os.environ.get('BACKOFFICE_DB_PASSWORD', ''),
        'HOST': os.environ.get('BACKOFFICE_DB_HOST', ''),
        'PORT': os.environ.get('BACKOFFICE_DB_PORT', ''),
    }

DATABASES = {
    'default': DEFAULT_DATABASE
}


# Password validation
# https://docs.djangoproject.com/en/3.0/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]


# Internationalization
# https://docs.djangoproject.com/en/3.0/topics/i18n/

LANGUAGE_CODE = 'en-us'

TIME_ZONE = 'UTC'

USE_I18N = True

USE_L10N = True

USE_TZ = True


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/3.0/howto/static-files/

STATIC_URL = '/static/'
STATIC_ROOT = '/srv/backoffice-static/'

ASGI_APPLICATION = 'backend.routing.application'

CHANNEL_LAYERS = {
    'default': {
        'BACKEND': 'channels_redis.core.RedisChannelLayer',
        'CONFIG': {
            "hosts": [('127.0.0.1', 6379)],
        },
    },
}

# REST framework

REST_FRAMEWORK = {
    'DEFAULT_PERMISSION_CLASSES': [
        'rest_framework.permissions.IsAuthenticated',
    ]
}