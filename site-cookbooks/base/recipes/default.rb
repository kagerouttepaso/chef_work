#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2014, kitsunai daisuke
#
# All rights reserved - Do Not Redistribute
#

include_recipe  "base::packages"
include_recipe  "base::dotfiles"
include_recipe  "base::group"

