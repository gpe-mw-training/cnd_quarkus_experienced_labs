#!/bin/bash

USER_PROJECT_NAME=gpte-${USER}-quarkus-deploy-lab

oc project ${USER_PROJECT_NAME}

mvn clean package -DskipTests

oc start-build people --from-file target/*-runner.jar --follow

oc rollout status -w dc/people