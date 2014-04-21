#!/bin/bash
RUBY_VERSION="`cat ./.ruby-version`"

#install rbenv
sudo apt-get install openssh-server git zlib1g-dev libssl-dev g++ autoconf
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

#install ruby and bundle
if [ "`rbenv versions | grep ${RUBY_VERSION}`" = "" ]; then
    rbenv install "${RUBY_VERSION}"
else
    echo "ruby ${RUBY_VERSION} is installed"
fi

#set ruby
rbenv local "${RUBY_VERSION}"
rbenv rehash
rbenv exec gem i bundler --no-ri --no-rdoc
rbenv rehash

# install pakagees of bundle and beaks
rbenv exec bundle install --path=.bundle
rbenv exec bundle exec berks vendor ./cookbooks
rbenv exec bundle exec berks update

#install chef
if [ "$2" = "init" ]; then
    echo "install chef ${HostName}"
    rbenv exec bundle exec knife solo prepare ${HostName}
fi

##cook
rbenv exec bundle exec knife solo cook ${HostName}
