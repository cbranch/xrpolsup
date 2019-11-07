.PHONY: all backend backoffice-frontend public-frontend deploy

all: backend backoffice-frontend public-frontend

backoffice-frontend:
	cd backoffice-frontend && npm install && npm run build

public-frontend:
	cd public-frontend && npm install && npm run build

backend:
	cd backend && npm install

deploy:
	sudo ./deploy.sh
