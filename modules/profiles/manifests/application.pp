class profiles::application {
  include docker

  ::docker::image { 'nginx': }

  ::docker::run { 'nginx-1':
    image   => 'nginx',
    ports   => ['8081:80'],
    volumes => '/var/www/nginx-1:/usr/share/nginx/html:ro'
  }

  file { '/var/www':
    ensure => directory,
  }

  file { '/var/www/nginx-1':
    ensure => directory,
  }

  file { '/var/www/nginx-1/index.html':
    ensure  => present,
    content => $::hostname,
  }

  ::consul::service { 'nginx-1':
    port => 8081,
  }

}
