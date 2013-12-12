#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{tmux zsh vim-nox exuberant-ctags tree aptitude ruby2.0 ruby2.0-dev git subversion git-svn xubuntu-desktop}.each do |pkg|
  package pkg do
    action :upgrade
  end
end

