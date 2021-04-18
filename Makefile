ifeq ($(ENVIRONMENT),staging)
BUILD_TASK := build-staging
else
BUILD_TASK := build
endif

.PHONY: all backend backoffice-frontend public-frontend deploy

all: backend backoffice-frontend public-frontend

backoffice-frontend:
	cd backoffice-frontend && npm install && npm run $(BUILD_TASK)

public-frontend:
	cd public-frontend && npm install && npm run $(BUILD_TASK)

backend:
	cd backend && npm install
	cd backend-django && pipenv install

deploy:
	sudo ./deploy.sh
