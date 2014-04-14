#
# Cookbook Name:: server_base
# Recipe:: nginx_start_page
#
# Copyright 2014, Daisuke Kitsunai
#
# All rights reserved - Do Not Redistribute
#

%w{/usr/share /usr/share/nginx /usr/share/nginx/www}.each do |dir|
  directory dir do
    owner "root"
    group "root"
    mode "755"
    action :create
  end
end


template "/usr/share/nginx/www/index.php" do
  source "index.php.erb"
  mode "644"
  owner "root"
  group "root"
end

#template File.join(node["nginx"]["dir"], "sites-available", "phptest") do
#  source "phptest.erb"
#  mode "644"
#  owner "root"
#  group "root"
#end
#
#nginx_site "phptest" do
#  enable true
#end
#

directory "/var/cache/nginx" do
  owner "www-data"
  group "www-data"
  mode "644"
  action :create
end

#template File.join("/etc/nginx/conf.d", "proxy.conf" ) do
#  source "proxy.conf.erb"
#  mode "644"
#  owner "root"
#  group "root"
#end

template File.join(node["nginx"]["dir"], "sites-available", "reverse") do
  source "reverse.erb"
  mode "644"
  owner "root"
  group "root"
end

nginx_site "reverse" do
  enable false
end
