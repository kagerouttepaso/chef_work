#
# Cookbook Name:: base
# Recipe:: package
#
# Copyright 2014, kitsunai daisuke
#
# All rights reserved - Do Not Redistribute


#package
%w{aptitude paco tree}.each do |pkg|
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

if node['platform_version'].to_f >= 14.04  then
  %w{docker.io}.each do |pkg|
    package pkg do
      action :upgrade
    end
  end
  simple_iptables_rule "shipyard" do
    rule "--proto tcp --dport 8000"
    jump "ACCEPT"
  end

  home_dir="/home/"+node[:current_user]
  execute "run docker ui" do
    user    node[:current_user]
    action  :nothing
    cwd     home_dir
    command "./install.sh"
    environment(
      "HOME" => home_dir
    )
  end
end
