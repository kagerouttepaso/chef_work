#
# Cookbook Name:: server_base
# Recipe:: default
#
# Copyright 2014, Daisuke Kitsunai
#
# All rights reserved - Do Not Redistribute
#

include_recipe "server_base::logwatch"
include_recipe "server_base::ntp"
include_recipe "server_base::nginx_start_page"


if node[:server_base][:do_test]
  include_recipe "server_base::owncloud"

  simple_iptables_rule "http" do
    rule [ "--proto tcp --dport 3000" ]
    jump "ACCEPT"
  end

  #jenkins
  # Allow HTTP,  HTTPS
  #simple_iptables_rule "http" do
  #  rule [ "--proto tcp --dport 8080"]
  #  jump "ACCEPT"
  #end

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
end
