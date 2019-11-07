# Arrestee Welfare & Legal support system

This repository hosts the public-facing arrestee witness and self-report forms, and the back office system used by volunteers and coordinators to view, edit and summarise the data collected.

## Environment

The backend system is a Sails.js webapp.

The back office frontend is a Vue app that communicates with the backend using Sails sockets for realtime updates.

The public frontend is a multipage Vue app hosting the arrestee forms, which posts to the backend API over HTTPS.

## Development

The frontend apps report to the backend system. See the README.md in each directory for instructions on how to run each one.

## Deployment

The systemd service should be installed (after setting the correct database credentials) to `/etc/systemd/system/`. 

The services can be built using the makefile - which is nothing more complicated than running `npm install` and `npm run build` in each directory - as well as deployed.
