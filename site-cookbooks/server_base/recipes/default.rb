#
# Cookbook Name:: server_base
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#mosh
simple_iptables_rule "mosh" do
  rule "--proto udp --dport 60000:61000"
  jump "ACCEPT"
end

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
  logwatch
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
  enable true
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
