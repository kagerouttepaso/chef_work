#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2014, kitsunai daisuke
#
# All rights reserved - Do Not Redistribute
#

#dotfiles
repo = '/home/'+node[:current_user]+'/dotfiles'

git repo do
  user node[:current_user]
  reference node[:base][:dotfilesrepo]
  repository 'https://github.com/kagerouttepaso/dotfiles.git'
  action :sync
  notifies :run, 'bash[after_sync]'
end

bash 'after_sync'do
  action :nothing
  flags '-x'
  code <<-__EOL__
  echo install dotfiles
  cd ~/dotfiles
  ./install.sh
  __EOL__
end
