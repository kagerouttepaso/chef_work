cookbook_path    ["cookbooks", "site-cookbooks", "private-cookbooks"]
node_path        ["nodes", "private-cookbooks/nodes"]
role_path        "roles"
environment_path "environments"
data_bag_path    "data_bags"
#encrypted_data_bag_secret "data_bag_key"

knife[:berkshelf_path] = "cookbooks"
ssl_verify_mode :verify_peer

#http_proxy  "http://172.16.2.9:80"
#https_proxy "http://172.16.2.9:80"
#no_proxy    "192.168.*"

#http_proxy  "http://172.16.100.151:3128"
#https_proxy "http://172.16.100.151:3128"
#no_proxy    "192.168.*"

if ENV["http_proxy"]
  require 'rest-client'
  RestClient.proxy = ENV["http_proxy"]

  require 'uri'
  proxy_env = URI.parse(ENV["http_proxy"])

  http_proxy "http://#{proxy_env.host}:#{proxy_env.port}"
  https_proxy "http://#{proxy_env.host}:#{proxy_env.port}"
  no_proxy "192.168.*"
end
