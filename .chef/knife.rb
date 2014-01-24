cookbook_path    ["cookbooks", "site-cookbooks"]
node_path        "nodes"
role_path        "roles"
environment_path "environments"
data_bag_path    "data_bags"
#encrypted_data_bag_secret "data_bag_key"

knife[:berkshelf_path] = "cookbooks"

#http_proxy  "http://172.16.2.9:80"
#https_proxy "http://172.16.2.9:80"
#ftp_proxy  "http://172.16.2.9:80"
#no_proxy    "192.168.*"

#http_proxy  "http://172.16.100.151:3128"
#https_proxy "http://172.16.100.151:3128"
#ftp_proxy   "http://172.16.100.151:3128"
#no_proxy    "192.168.*"

