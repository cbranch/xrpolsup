FROM python:3.7-slim-buster
RUN pip install pipenv
WORKDIR /opt/backend-django
# dep layer
COPY ["Pipfile", "Pipfile.lock", "/tmp/"]
RUN cd /tmp && pipenv lock --keep-outdated --requirements > requirements.txt
RUN pip install -r /tmp/requirements.txt
# code layer
COPY backend/ .

EXPOSE 8081
CMD gunicorn --access-logfile - --workers 3 --bind 0.0.0.0:8080 backend.wsgi:application