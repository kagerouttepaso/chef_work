#
# Cookbook Name:: arm-linux
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "gcc-arm-linux-gnueabi" do
  action :upgrade
end

#for u-boot
link "/usr/bin/arm-linux-ar" do
  to "/usr/arm-linux-gnueabi/bin/ar"
end
link "/usr/bin/arm-linux-as" do
  to "/usr/arm-linux-gnueabi/bin/as"
end
link "/usr/bin/arm-linux-ld" do
  to "/usr/arm-linux-gnueabi/bin/ld"
end
link "/usr/bin/arm-linux-ld.bfd" do
  to "/usr/arm-linux-gnueabi/bin/ld.bfd"
end
link "/usr/bin/arm-linux-ld.gold" do
  to "/usr/arm-linux-gnueabi/bin/ld.gold"
end
link "/usr/bin/arm-linux-nm" do
  to "/usr/arm-linux-gnueabi/bin/nm"
end
link "/usr/bin/arm-linux-objcopy" do
  to "/usr/arm-linux-gnueabi/bin/objcopy"
end
link "/usr/bin/arm-linux-objdump" do
  to "/usr/arm-linux-gnueabi/bin/objdump"
end
link "/usr/bin/arm-linux-ranlib" do
  to "/usr/arm-linux-gnueabi/bin/ranlib"
end
link "/usr/bin/arm-linux-strip" do
  to "/usr/arm-linux-gnueabi/bin/strip"
end
link "/usr/bin/arm-linux-gcc" do
  to "/usr/bin/arm-linux-gnueabi-gcc"
end
link "/usr/bin/arm-linux-readelf" do
  to "/usr/bin/arm-linux-gnueabi-readelf"
end
