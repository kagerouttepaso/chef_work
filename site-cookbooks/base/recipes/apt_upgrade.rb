#
# Cookbook Name:: base
# Recipe:: apt_upgrade
#
# Copyright 2014, kitsunai daisuke
#
# All rights reserved - Do Not Redistribute
#

if node['platform'] == "ubuntu"  then
  #update
  home_dir="/home/"+node[:current_user]
  execute "apt-get_upgrade" do
    user    "root"
    action  :run
    cwd     home_dir
    command "apt-get -y dist-upgrade"
    environment(
      "HOME" => home_dir
    )
  end
end
