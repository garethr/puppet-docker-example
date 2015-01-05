class profiles::webserver {
  include nginx

  $nginx_array = hiera('nginx-1', [])

  ufw::allow { 'allow-http-from-all':
    port => 80,
    ip   => 'any',
  }

  unless empty($nginx_array) {

    $members = consul_to_nginx($nginx_array)
    notify { 'members':
      message => $members,
    }

    ::nginx::resource::upstream { 'app':
      members => $members,
    }
    ::nginx::resource::vhost { 'default':
      proxy => 'http://app',
    }
  }

}
