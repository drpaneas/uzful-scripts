#!/bin/bash

# Requirements:
# docker engine, curl, python

# Usage: ./docker-tags.sh opensuse

name="$1"
for tag in $(curl --silent https://registry.hub.docker.com//v1/repositories/"$name"/tags | python -mjson.tool | grep name | cut -d ':' -f2); do
    echo "$tag"
done
