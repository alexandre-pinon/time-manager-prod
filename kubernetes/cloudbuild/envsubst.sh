#!/bin/bash

FILENAME=$1

apt-get -y install gettext-base

echo "Processing $FILENAME ..."

envsubst < $FILENAME > $FILENAME-bak

echo "Finished modifying file"

mv $FILENAME-bak $FILENAME