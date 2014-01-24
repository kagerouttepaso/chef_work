#
# Cookbook Name:: server_base
# Recipe:: nginx_start_page
#
# Copyright 2014, Daisuke Kitsunai
#
# All rights reserved - Do Not Redistribute
#

template "/usr/share/nginx/www/index.php" do
  source "index.php.erb"
  mode "644"
  owner "root"
  group "root"
end

template File.join(node["nginx"]["dir"], "sites-available", "phptest") do
  source "phptest.erb"
  mode "644"
  owner "root"
  group "root"
end

nginx_site "phptest" do
  enable true
end
