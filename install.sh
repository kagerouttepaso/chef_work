#!/bin/bash
sudo apt-get install openssh-server git
if [ ! -d ~/.rbenv ]; then
    git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
    git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
fi
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

#Set up Hostname
if [ "$1" = "" ]; then
    HostName="localhost"
else
    HostName=$1
fi

#install package
if [ ! -f "installed.lock" ]; then
    rbenv install 1.9.3-rc1
    rbenv local 1.9.3-rc1
    rbenv rehash
    rbenv exec gem i bundler --no-ri --no-rdoc
fi

rbenv exec bundle install --path=.bundle
rbenv exec bundle exec berks --path=cookbooks
rbenv exec bundle exec berks update

#install chef
if [ ! -f "installed.lock" ]; then
    rbenv exec bundle exec knife solo prepare localhost
    touch installed.lock
fi

##cook
rbenv exec bundle exec knife solo cook ${HostName}
