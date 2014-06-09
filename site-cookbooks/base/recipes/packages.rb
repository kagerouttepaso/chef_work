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
#  home_dir="/home/"+node[:current_user]
#  execute "run docker ui" do
#    user    "root"
#    action  :nothing
#    command <<-EOH
#    docker.io run -i -t -v /var/run/docker.sock:/docker.sock shipyard/deploy setup
#    curl https://github.com/shipyard/shipyard-agent/releases/download/v0.3.1/shipyard-agent -L -o /usr/local/bin/shipyard-agent
#    chmod +x /usr/local/bin/shipyard-agent
#    shipyard-agent -url http://172.16.6.10:8000 -register
#    EOH
#  end
end
