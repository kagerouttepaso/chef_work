#!/bin/bash

bundle install --path=bundle
bundle exec berks --path=cookbooks
bundle exec knife solo cook localhost
