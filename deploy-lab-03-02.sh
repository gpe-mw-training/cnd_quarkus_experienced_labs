#!/bin/bash

USER_PROJECT_NAME=gpte-${USER}-quarkus-deploy-lab

oc ${USER_PROJECT_NAME}

oc new-app \
    -e POSTGRESQL_USER=sa \
    -e POSTGRESQL_PASSWORD=sa \
    -e POSTGRESQL_DATABASE=person \
    --name=postgres-database \
    openshift/postgresql

mvn clean package -DskipTests

oc new-build registry.access.redhat.com/openjdk/openjdk-11-rhel7:1.1 --binary --name=people

oc start-build people --from-file target/*-runner.jar --follow

oc rollout status -w dc/people