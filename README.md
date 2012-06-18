solo-deploy
===========

A bash script for chef-solo deployment

There are a few active tools which I like (pocketknife and littlechef), however, when the chef-solo run breaks, it can be hard to diagnose.  Therein lies the reason for this scripts existence.

It assumes that chef is installed and there is a /etc/chef/solo.rb file like this:

	#/etc/chef/solo.rb
	file_cache_path "/tmp/chef-solo"
	cookbook_path ["/tmp/chef-solo/cookbooks", "/tmp/chef-solo/site-cookbooks"]
	role_path "/tmp/chef-solo/roles"
	data_bag_path "/tmp/chef-solo/data-bags"
	json_attribs "/tmp/chef-solo/node.base.json"
	recipe_url "/tmp/chef-solo/chef-solo.tar.gz"
