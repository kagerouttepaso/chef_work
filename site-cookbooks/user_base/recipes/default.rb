#
# Cookbook Name:: user_base
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#to enabele password of user_account
gem_package "ruby-shadow" do
  action :upgrade
end
