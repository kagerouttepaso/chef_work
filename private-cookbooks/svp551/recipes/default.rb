#
# Cookbook Name:: svp551
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#

package "gcc-4.8-powerpc-linux-gnu" do
  action :upgrade
end

link "/usr/bin/powerpc-linux-gnu-gcc" do
  to "/usr/bin/powerpc-linux-gnu-gcc-4.8"
end
