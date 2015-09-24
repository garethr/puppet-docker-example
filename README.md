# Docker Puppet Example

The [Puppet Docker module](https://forge.puppetlabs.com/garethr/docker)
is a great way of installing and managing Docker on a host, but it also
allows for some basic container management. This repo contains a fairly
advanced example using Puppet, Docker, Consul and Vagrant.

## Usage

    bundle install
    librarian-puppet init
    vagrant plugin install vagrant-hosts
    vagrant up --provider virtualbox
    vagrant provision

This will take a little time as it launches three virtual machines and
downloads lots of software for them.

## What happened?

Once up you should be able to access [10.20.1.13](http://10.20.1.13/)
and it should print the text _client-appserver-2_.

The text is coming from a docker container on the host
`client-appserver-2`, proxied through the nginx on `client-webserver-3`.

So far, not very interesting.

## Next

    INSTANCES=4 vagrant up --provider virtualbox
    vagrant provision client-webserver-3

Here we're launching a fourth virtual machine, another application
server. We're then kicking the webserver to update it's configuration.

Note that you can increase the INSTANCES count until you run out of
computer, it will launch alternating webservers and application servers
and running `provision` on the webservers will add any new app servers
the proxy.

Visit [10.20.1.13](http://10.20.1.13/) again and refresh a few times, it
should print _client-appserver-2_ or _client-appserber-4_, regularly
swapping between the two.

## Under the hood

1. The first instance (`master-1`)  acts as a Consul master
2. The second instance (`client-appserver-2`) installs docker, downloads
   the official nginx docker image and runs a container based on that
   image. It also regisers a service in Consul pointing at the container
   port
3. The third instance (`client-webserver-3`) installs nginx and checks
   Consul (via the [Consul Hiera backend](https://github.com/lynxman/hiera-consul/))
   for any services, automatically creating a proxy if it finds any

For those unfamiliar with the Puppet roles and profiles pattern the
interesting Puppet code is found in the [application
profile](modules/profiles/manifests/application.pp) and the [webserver
profile](modules/profiles/manifests/webserver.pp).

## Improvements

This could be improved by running Puppet as an agent on each of the
machines, which would remove the need for the additional provisioning
runs. You could also trigger a Puppet run whenever a new application
server is added by watching the Consul API with
[Confd](https://github.com/kelseyhightower/confd) or similar.
