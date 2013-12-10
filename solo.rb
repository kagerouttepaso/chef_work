file_chach_path "/tmp/chef-solo"
cookbook_path [
  File::expand_path( File::dirname(__FILE__)) + "/cookbooks",
  File::expand_path( File::dirname(__FILE__)) + "/site-cookbooks"
]
