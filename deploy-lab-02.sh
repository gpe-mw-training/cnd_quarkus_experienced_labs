#!/bin/bash

mvn clean package

USER_PROJECT_NAME=gpte-${USER}-quarkus-deploy-lab

oc new-project ${USER_PROJECT_NAME}

oc new-build registry.access.redhat.com/openjdk/openjdk-11-rhel7:1.1 --binary --name=people -l app=people

oc start-build people --from-file target/*-runner.jar --follow

oc new-app people && oc expose svc/people

oc set probe dc/people --readiness --initial-delay-seconds=30 --get-url=http://:8080/health/ready
oc set probe dc/people --liveness --initial-delay-seconds=30 --get-url=http://:8080/health/live

oc rollout status -w dc/people

