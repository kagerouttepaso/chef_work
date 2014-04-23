#
# Cookbook Name:: base
# Recipe:: group
#
# Copyright 2014, kitsunai daisuke
#
# All rights reserved - Do Not Redistribute
#

%w{docker vboxsf}.each do |grp|
  group grp do
    action :manage
    members node[:current_user]
    append true
  end
end
