.PHONY: all backoffice-frontend public-frontend

all: backoffice-frontend public-frontend

backoffice-frontend:
	cd backoffice-frontend && npm install && npm run build

public-frontend:
	cd public-frontend && npm install && npm run build
