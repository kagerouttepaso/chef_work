#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#most need
%w{tmux zsh pandoc exuberant-ctags tree xclip}.each do |pkg|
  package pkg do
    action :upgrade
  end
end


#package
%w{aptitude paco}.each do |pkg|
  package pkg do
    action :upgrade
  end
end

#ruby
%w{ruby ruby-dev rubygems gem}.each do |pkg|
  package pkg do
    action :upgrade
  end
end

#version manager
%w{git subversion git-svn tig}.each do |pkg|
  package pkg do
    action :upgrade
  end
end

#mosh
package "mosh" do
  action :upgrade
end
simple_iptables_rule "mosh" do
  rule "--proto udp --dport 60000:61000"
  jump "ACCEPT"
end


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
