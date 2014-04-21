#
# Cookbook Name:: user_base
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#enable ruby
package "ruby1.9.3 ruby-dev gem" do
  action :install
end

#to enabele password of user_account
gem_package "ruby-shadow" do
  action :install
end
