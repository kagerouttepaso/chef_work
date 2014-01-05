#
# Cookbook Name:: desktop
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{lubuntu-desktop}.each do |pkg|
  package pkg do
    action :upgrade
  end
end
