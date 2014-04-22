#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2014, kitsunai daisuke
#
# All rights reserved - Do Not Redistribute
#

if node['platform_version'].to_f >= 13.04  then
  %w{silversearcher-ag}.each do |pkg|
    package pkg do
      action :upgrade
    end
  end
end

#most need
%w{git tmux zsh pandoc exuberant-ctags xclip curl}.each do |pkg|
  package pkg do
    action :upgrade
  end
end

#dotfiles
repo = '/home/'+node[:current_user]+'/dotfiles'

git repo do
  user node[:current_user]
  reference node[:base][:dotfilesrepo]
  repository 'https://github.com/kagerouttepaso/dotfiles.git'
  action :sync
  notifies :run, 'execute[after_sync]', :immediately
end

home_dir="/home/"+node[:current_user]
execute "after_sync" do
  user    node[:current_user]
  action  :nothing
  cwd     home_dir+"/dotfiles"
   command "./install.sh"
  environment(
    "HOME" => home_dir
  )
end
