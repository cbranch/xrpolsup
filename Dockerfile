# public-frontend directory
FROM node:12 AS public-frontend
WORKDIR /opt/public-frontend
# dep layer
COPY public-frontend/package*.json ./
RUN npm ci
# code layer
COPY public-frontend/. .
RUN npm run build

# backoffice-frontend directory
FROM node:12 AS backoffice-frontend
WORKDIR /opt/backoffice-frontend
# dep layer
COPY backoffice-frontend/package*.json ./
RUN npm ci
# code layer
COPY backoffice-frontend/. .
RUN npm run build

# backend directory
FROM node:12 AS backend
WORKDIR /opt/backend
# dep layer
COPY backend/package*.json ./
RUN npm ci
# code layer
COPY backend/. .
# frontend assets
COPY --from=public-frontend /opt/backend/assets/. assets/.
COPY --from=backoffice-frontend /opt/backend/assets/. assets/.
# server
EXPOSE 8080
#CMD ["npm", "run", "start"]
CMD ["node", "--inspect=0.0.0.0:9229", "app.js"]