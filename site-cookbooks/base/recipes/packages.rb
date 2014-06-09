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
  #  %w{docker.io}.each do |pkg|
  #    package pkg do
  #      action :upgrade
  #    end
  #  end
  #
  #  template "/etc/default/docker.io" do
  #    source "docker.io.erb"
  #    mode "644"
  #    owner "root"
  #    group "root"
  #    variables({
  #      :proxy => node[:base][:docker][:proxy], 
  #      :dns   => node[:base][:docker][:dns]
  #    })
  #    notifies :run, "execute[restart_docker.io]", :immediately
  #  end
  #
  #  service "docker.io" do
  #    supports :status => true, :restart => true
  #    action [:enable]
  #  end
  #
  #  execute "restart_docker.io" do
  #    user    "root"
  #    action  :nothing
  #    command <<-EOH
  #    service docker.io restart
  #    EOH
  #  end
#  
#  %w{docker.io}.each do |pkg|
#    package pkg do
#      action :purge
#    end
#  end
#
#  package "linux-image-extra-#{`uname -r`.strip}" do
#    action :upgrade
#  end
#
#  #apt_repository "docker" do
#  #  uri "https://get.docker.io/ubuntu docker"
#  #  components ["main"]
#  #  keyserver "https://keyserver.ubuntu.com"
#  #  key "36A1D7869245C8950F966E92D8576A8BA88D21E9"
#  #end
#  
#  execute "install docker" do
#    user    "root"
#    action  :run
#    command <<-EOH
#    curl -L https://get.docker.io/ubuntu | bash
#    EOH
#    creates "/etc/default/docker"
#  end
#
#  package "lxc-docker" do
#    action :upgrade
#  end
#
#  template "/etc/default/docker" do
#    source "docker.io.erb"
#    mode "644"
#    owner "root"
#    group "root"
#    variables({
#      :proxy => node[:base][:docker][:proxy], 
#      :dns   => node[:base][:docker][:dns]
#    })
#    notifies :run, "execute[restart_docker]", :immediately
#  end
#
#  service "docker" do
#    supports :status => true, :restart => true
#    action [:enable]
#  end
#
#  execute "restart_docker" do
#    user    "root"
#    action  :nothing
#    command <<-EOH
#    service docker restart
#    EOH
#  end
#
#  simple_iptables_rule "shipyard" do
#    rule "--proto tcp --dport 8000"
#    jump "ACCEPT"
#  end
#
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
