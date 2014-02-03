#
# Cookbook Name:: base
# Recipe:: package
#
# Copyright 2014, kitsunai daisuke
#
# All rights reserved - Do Not Redistribute

#most need
%w{git tmux zsh pandoc exuberant-ctags xclip curl silversearcher-ag}.each do |pkg|
  package pkg do
    action :upgrade
  end
end


#package
%w{aptitude paco tree}.each do |pkg|
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
%w{subversion git-svn tig}.each do |pkg|
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
