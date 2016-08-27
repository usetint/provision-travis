This sunzi recipe will configure a machine with travis-worker, docker, and a docker image that can be used with tint for builds.

Tested with Debian Jessie.

    bundle install --path=.gems
    bundle exec sunzi deploy --sudo $IP_ADDRESS
