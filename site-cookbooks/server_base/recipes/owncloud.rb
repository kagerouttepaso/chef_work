#
# Cookbook Name:: server_base
# Recipe:: owncloud
#
# Copyright 2014, Daisuke Kitsunai
#
# All rights reserved - Do Not Redistribute
#

if( node["platform"] == "ubuntu")
  apt_repository "owncloud" do
    uri "http://download.opensuse.org/repositories/isv:/ownCloud:/community/xUbuntu_" + node["platform_version"]
    components ["/"]
    key "http://download.opensuse.org/repositories/isv:ownCloud:community/xUbuntu_" + node["platform_version"] + "/Release.key"
  end

  package "owncloud-sqlite" do
    action :upgrade
  end

  package "owncloud" do
    action :upgrade
  end

  simple_iptables_rule "http" do
    rule [ "--proto tcp --dport 10000"]
    jump "ACCEPT"
  end

  php_fpm_pool "owncloud" do
    user  node["nginx"]["user"]
    group node["nginx"]["group"]
    php_options({
      "php_admin_value[upload_max_filesize]" => "1000M",
      "php_admin_value[post_max_size]" => "1000M"
    })
  end

  nginx_site "owncloud" do
    template "owncloud.erb"
    port 10000
    docroot "/var/www/owncloud"
    directory_index "index.php"
    default_server true
    enable true
  end
end
