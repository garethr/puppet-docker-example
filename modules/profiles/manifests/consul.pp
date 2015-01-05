class profiles::consul {
  include consul

  ufw::allow { 'allow-serf-from-all':
    port => 8301,
    ip   => 'any',
  }

  # Only require by the server
  ufw::allow { 'allow-consul-server-from-all':
    port => 8300,
    ip   => 'any',
  }

  ufw::allow { 'allow-consul-dns-from-all':
    port => 8600,
    ip   => 'any',
  }

  ufw::allow { 'allow-consul-http-from-all':
    port => 8500,
    ip   => 'any',
  }

  dnsmasq::conf { 'consul':
    ensure  => present,
    content => 'server=/consul/127.0.0.1#8600',
  }

}
