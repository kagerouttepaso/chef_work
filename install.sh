#!/bin/bash
cd `dirname $0`
RUBY_VERSION="`cat ./.ruby-version`"

#install rbenv
sudo apt-get install -y openssh-server git zlib1g-dev libssl-dev g++ autoconf make gcc
if [ ! -d ~/.rbenv ]; then
    git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
    git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
fi
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"


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

#Set up Hostname
if [ "$1" = "" ]; then
    HostName="localhost"

    #put tmp ssh keys
    if [ ! -d ~/.ssh ]; then
        echo ~/.ssh is not found. put tmp ssh keys
        mkdir ~/.ssh && chmod 700 ~/.ssh
        cp ./.tmpsshkeys/id_rsa      ~/.ssh/id_rsa          && chmod 600 ~/.ssh/id_rsa
        cp ./.tmpsshkeys/id_rsa.pub  ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys
        cp ./.tmpsshkeys/id_rsa.pub  ~/.ssh/id_rsa.pub      && chmod 644 ~/.ssh/id_rsa.pub
        ssh-keyscan localhost >> ~/.ssh/known_hosts
        touch ./.tmpsshkeys/put
    fi

    # install chef-client
    if ! builtin command -v chef-client >> /dev/null ; then
        echo chef-client is not installed on this PC
        echo chef-client install
        sudo apt-get install curl bash
        curl -L https://www.opscode.com/chef/install.sh | sudo bash
    fi

else
    HostName=$1
fi

#install chef
if [ "$2" = "init" ]; then
    echo "install chef ${HostName}"
    rbenv exec bundle exec knife solo prepare ${HostName}
fi

##cook
rbenv exec bundle exec knife solo cook ${HostName}

if [ -f ./.tmpsshkeys/put ]; then
    echo rm tmp ssh keys
    rm ~/.ssh/id_rsa
    rm ~/.ssh/authorized_keys
    rm ~/.ssh/id_rsa.pub
    rm ~/.ssh/known_hosts
    rm ./.tmpsshkeys/put
fi
