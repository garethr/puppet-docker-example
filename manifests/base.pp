Exec {
  path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
}

# this is a hack to work around
# https://github.com/saz/puppet-dnsmasq/issues/10
define common::line { }

node 'master-1' {
  include roles::master
}

node /^client-webserver-/ {
  include roles::web
}

node /^client-appserver-/ {
  include roles::app
}
