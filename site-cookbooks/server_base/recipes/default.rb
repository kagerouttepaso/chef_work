#
# Cookbook Name:: server_base
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#logwatch
package "logwatch" do
  action :upgrade
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
