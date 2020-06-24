#!/bin/bash

USER_PROJECT_NAME=gpte-${USER}-quarkus-deploy-lab

oc project ${USER_PROJECT_NAME}

oc new-app \
    -e POSTGRESQL_USER=sa \
    -e POSTGRESQL_PASSWORD=sa \
    -e POSTGRESQL_DATABASE=person \
    --name=postgres-database \
    openshift/postgresql

mvn clean package -DskipTests

oc start-build people --from-file target/*-runner.jar --follow

oc rollout status -w dc/people