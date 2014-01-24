#
# Cookbook Name:: server_base
# Recipe:: ntp
#
# Copyright 2014, Daisuke Kitsunai
#
# All rights reserved - Do Not Redistribute
#

#ntp
package "ntp" do
  action :upgrade
end

service "ntp" do
  supports :status => true, :restart => true
  action [:enable, :start]
end

template "/etc/ntp.conf" do
  mode "644"
  source "ntp.conf.erb"
  variables ({
    :ntp_server => node[:server_base][:ntp_server]
  })
  notifies :restart, "service[ntp]"
end
