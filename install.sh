#!/bin/bash

sudo apt-get install ruby2.0 chef
sudo gem2.0 i bundler
bundle install --path=bundle
bundle exec berks --path=cookbooks
if [ "$1" = "oshigoto" ]; then
    bundle exec knife solo cook oshigoto
else
    bundle exec knife solo cook localhost
fi
