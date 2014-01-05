#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{tmux zsh vim-nox exuberant-ctags tree aptitude ruby ruby-dev rubygems gem git subversion git-svn tig paco mosh}.each do |pkg|
  package pkg do
    action :upgrade
  end
end

#mosh
simple_iptables_rule "mosh" do
  rule "--proto udp --dport 60000:61000"
  jump "ACCEPT"
end

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
