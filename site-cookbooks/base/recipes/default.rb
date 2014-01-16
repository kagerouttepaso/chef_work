#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#most need
%w{tmux zsh pandoc exuberant-ctags tree}.each do |pkg|
  package pkg do
    action :upgrade
  end
end

package "vim" do
  action  :remove
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

#vim from souce
vim_source_path = ::File.join(Chef::Config[:file_cache_path], "vim-7.4.tar.bz2");
remote_file "download source of vim" do
  source "http://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2"
  path vim_source_path
  action :create_if_missing
  owner "root"
  group "root"
  mode "644"
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
