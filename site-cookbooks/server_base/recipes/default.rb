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

#nginx
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
if node[:do_test]
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
      mode "755"
      action :create
    end
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
