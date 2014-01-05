#
# Cookbook Name:: server_base
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#logwatch
directory "/var/cache/logwatch" do
  owner "root"
  group "root"
  mode 0644
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
  mode 0644
  owner "root"
  group "root"
  variables ({
    :mail_to => node[:server_base][:mail_to]
  })
end

#nginx
template "/usr/share/nginx/www/index.php" do
  source "index.php.erb"
  mode 0644
  owner "root"
  group "root"
end

template "/etc/nginx/sites-available/phptest" do
  source "phptest.erb"
  mode 0644
  owner "root"
  group "root"
end

nginx_site "phptest" do
#  enable true
  enable true
end

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

%w{/var/www /var/www/html}.each do |dir|
  directory dir do
    owner "www-data"
    group "www-data"
    mode 0755
    action :create
  end
end

remote_file "/var/www/owncloud-6.0.0a.tar.bz2" do
  source "http://download.owncloud.org/community/owncloud-6.0.0a.tar.bz2"
  action :create_if_missing
  owner "www-data"
  group "www-data"
  mode 0644
  notifies :run, "execute[extract_owncloud]", :immediately
end

execute "extract_owncloud" do
  command <<-EOH
  tar -xjf owncloud-6.0.0a.tar.bz2
  chown -R www-data:www-data owncloud
  EOH
  cwd "/var/www/html"
  user "root"
  action :nothing
end

#wordpress
#%w{tar wget php5 php5-fpm php5-mysql phpmyadmin}.each do |pkg|
#  package pkg do
#    action :upgrade
#  end
#end
#
#template "/etc/php5/fpm/pool.d/www.conf" do
#  source "www.conf.erb"
#  owner "root"
#  group "root"
#  mode 0644
#  action :create
#end
#
#%w{/var/www /var/www/html /tmp/chef}.each do |dir|
#  directory dir do
#    owner "root"
#    group "root"
#    mode 0644
#    action :create
#  end
#end
#
#remote_file "/tmp/chef/wordpress-3.8-ja.tar.gz" do
#  source "http://ja.wordpress.org/wordpress-3.8-ja.tar.gz"
#  action :create_if_missing
#  owner "root"
#  group "root"
#  mode 0644
#end
#
#execute "get_wordpress" do
#  command <<-EOH
#  tar zxvf wordpress-3.8-ja.tar.gz
#  sudo chown -R www-data:www-data wordpress
#  EOH
#  cwd "/tmp/chef"
#  user "root"
#  #creates "/var/www/html/wordpress-3.8-ja.tar.gz"
#  action :run
#end
#
#%w{/tmp/chef/wordpress /tmp/chef/wordpress/wp-content}.each do |dir|
#  directory dir do
#    owner "www-data"
#    group "www-data"
#    mode 0777
#    action :create
#  end
#end
