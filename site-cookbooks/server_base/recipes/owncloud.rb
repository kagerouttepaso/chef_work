#
# Cookbook Name:: server_base
# Recipe:: owncloud
#
# Copyright 2014, Daisuke Kitsunai
#
# All rights reserved - Do Not Redistribute
#


#owncloud
#"owncloud" : {
#  "www_dir" : "/var/www",
#  "web_server" : "nginx",
#  "server_aliases" : "owncloud",
#  "ssl" : false,
#  "admin" : {
#    "user" : "admin",
#    "pass" : "owncloud"
#  },
#  "config" : {
#    "dbtype" : "mysql",
#    "dbpassword" : "owncloud"
#  }
#},
mysql_connection_info = {
  :host => "localhost",
  :username => "root",
  :password => node["mysql"]["server_root_password"]
}

mysql_database "owncloud" do
  connection mysql_connection_info
  action :create
end

mysql_database_user "owncloud" do
  connection mysql_connection_info
  database_name "owncloud"
  password "owncloud"
  privileges [:all]
  action :grant
end


owncloud_path = ::File.join(Chef::Config[:file_cache_path], "owncloud-6.0.0a.tar.bz2")

remote_file 'download owncloud' do
  source "http://download.owncloud.org/community/owncloud-6.0.0a.tar.bz2"
  path owncloud_path
  action :create_if_missing
  owner "root"
  group "root"
  mode "644"
end

execute "extract_owncloud" do
  command "
  tar -xjf #{owncloud_path} &&
  chown -R www-data:www-data owncloud
  "
  not_if do FileTest.directory?("/var/www/owncloud") end
  cwd "/var/www"
  user "root"
end

php_fpm_pool "owncloud" do
  user  node["nginx"]["user"]
  group node["nginx"]["group"]
  php_options({
    "php_admin_value[upload_max_filesize]" => "512M",
    "php_admin_value[post_max_size]" => "512M"
  })
end

fastcgi_pass = "unix:/var/run/php-fpm-owncloud.sock"
template File.join(node["nginx"]["dir"], "sites-available", "owncloud") do
  source "owncloud.erb"
  mode   "0644"
  owner  "root"
  group  "root"
  variables(
    :name             => "owncloud",
    :docroot          => "/var/www/owncloud",
    :port             => 10000,
    :max_upload_size  => "512M",
    :fastcgi_pass     => fastcgi_pass
  )
  notifies :reload, "service[nginx]"
end

nginx_site "owncloud" do
  enable true
end

simple_iptables_rule "http" do
  rule [ "--proto tcp --dport 10000"]
  jump "ACCEPT"
end
