#!/bin/bash

OLD="v0.28.0"
curl --silent https://github.com/kubernetes/minikube/releases/latest | grep "$OLD"
RC="$?"
if [ $RC -ne 0 ]; then
    NEW=$(curl --silent https://github.com/kubernetes/minikube/releases/latest | awk -F "tag/" '{print $2}' | awk -F '"' '{ print $1 }')
    CHANGELOG="https://github.com/kubernetes/minikube/blob/master/CHANGELOG.md"
    echo "New Version $NEW"
    echo "Read the changelog at $CHANGELOG" |  mail -s "Minikube $NEW version released" pgeorgiadis@suse.de
fi

