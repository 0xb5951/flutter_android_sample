#!/bin/bash
CONTAINER_ALREADY_STARTED="CONTAINER_ALREADY_STARTED_PLACEHOLDER"
if [ ! -e $CONTAINER_ALREADY_STARTED ]; then
    touch $CONTAINER_ALREADY_STARTED
    echo "-- First container startup --"
    while true; do sleep 1000; done
else
    echo "-- Not first container startup --"
    sudo chown circleci -R /dev/kvm
fi
