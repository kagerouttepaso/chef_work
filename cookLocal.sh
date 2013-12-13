#!/bin/bash
if [ "$1" = "" ]; then
    HostName="localhost"
else
    HostName=$1
fi
sudo chef-solo -c ./solo.rb -j ./nodes/${HostName}.json
