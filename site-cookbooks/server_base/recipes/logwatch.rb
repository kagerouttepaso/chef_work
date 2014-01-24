#
# Cookbook Name:: server_base
# Recipe:: logwatch
#
# Copyright 2014, Daisuke Kitsunai
#
# All rights reserved - Do Not Redistribute
#

directory "/var/cache/logwatch" do
  owner "root"
  group "root"
  mode "644"
  action :create
end

package "logwatch" do
  action :upgrade
  notifies :run, "execute[copy_logwatch_services]"
end

execute "copy_logwatch_services" do
  command <<-EOH
  rm -rf ./*
  cp /usr/share/logwatch/default.conf/services/* .
  EOH
  cwd "/etc/logwatch/conf/services"
  user "root"
  action :nothing
end

template "/etc/logwatch/conf/logwatch.conf" do
  source "logwatch.conf.erb"
  mode "644"
  owner "root"
  group "root"
  variables ({
    :mail_to => node[:server_base][:mail_to]
  })
end

