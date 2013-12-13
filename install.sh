#!/bin/bash
if [ ! -f "installed.lock" ]; then
    sudo apt-get install ruby ruby2.0 ruby2.0-dev
    sudo gem2.0 i bundler --no-ri --no-rdoc
fi
bundle install --path=bundle
bundle exec berks --path=cookbooks
if [ ! -f "installed.lock" ]; then
    bundle exec knife solo prepare localhost
    knife configre
    touch installed.lock
fi
./cookLocal.sh
