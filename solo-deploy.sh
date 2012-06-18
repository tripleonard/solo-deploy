#!/bin/bash

# You must be in your chef-solo directory to run. DNS must resolve node name.
echo "Enter node name (must resolve in DNS): "
read node

#Enter user whose public key is on server (root first run, then admin user)
echo "Enter run as user name: "
read user_name

# Start timer.
before="$(date +%s)"

# Create new tarball of recipes, cookbooks, etc. - necessary for chef-solo
tar zcf chef-solo.tar.gz ./cookbooks ./roles ./site-cookbooks ./data-bags ./nodes

# Remove previous tarball if exists
ssh -t $user_name@$node sudo rm -r /tmp/chef-solo/

# Copy over tarball and node.json config file to /tmp/chef-solo   
rsync -avzh ./nodes/$node.json $user_name@$node:/tmp/chef-solo/
rsync -avzh ./chef-solo.tar.gz $user_name@$node:/tmp/chef-solo/

# Execute chef-solo on node
ssh -t $user_name@$node sudo chef-solo -j /tmp/chef-solo/$node.json -r /tmp/chef-solo/chef-solo.tar.gz

# End timer.
after="$(date +%s)"
elapsed_seconds="$(expr $after - $before)"
echo Elapsed time for deploy: $elapsed_seconds seconds