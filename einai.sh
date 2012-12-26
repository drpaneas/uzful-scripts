#!/bin/bash

for package; do
    dpkg -s "$package" >/dev/null 2>&1 && {
        echo "$package is installed."
    } || {
        echo "$package is not installed."
    }
done
echo
