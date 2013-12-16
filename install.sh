#!/bin/bash

#Set up Hostname
if [ "$1" = "" ]; then
    HostName="localhost"
else
    HostName=$1
fi

#install package
if [ ! -f "installed.lock" ]; then
    sudo apt-get install ruby ruby2.0 ruby2.0-dev openssh-server
    sudo gem2.0 i bundler --no-ri --no-rdoc
fi

bundle install --path=.bundle
bundle exec berks --path=cookbooks

#install chef
if [ ! -f "installed.lock" ]; then
    bundle exec knife solo prepare localhost
    touch installed.lock
fi

#cook
bundle exec knife solo cook ${HostName}
