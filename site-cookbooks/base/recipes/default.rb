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

git '/home/'+node[:current_user]+'/dotfiles' do
  action :sync
  repository 'https://github.com/kagerouttepaso/dotfiles.git'
  notifies :run, 'bash[after_sync]'
end

bash 'after_sync'do
  action :nothing
  flags '-x'
  code <<-__EOL__
  echo hello
  __EOL__
end
