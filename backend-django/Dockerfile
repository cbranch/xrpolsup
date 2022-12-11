FROM python:3.7-slim-buster
RUN pip install pipenv
WORKDIR /opt/backend-django
# dep layer
COPY ["Pipfile", "Pipfile.lock", "./"]
RUN pipenv install
# code layer
COPY backend/ .

EXPOSE 8081
CMD pipenv run gunicorn --access-logfile - --workers 3 --bind 0.0.0.0:8080 backend.wsgi:application