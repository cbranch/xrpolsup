.PHONY: shell

shell:
	pipenv run backend/manage.py shell

dev:
	pipenv run backend/manage.py migrate
	pipenv run backend/manage.py runserver