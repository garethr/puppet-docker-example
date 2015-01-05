class profiles::base {

  hiera_include('classes')

  sudo::conf { 'vagrant':
    priority => 30,
    content  => 'vagrant ALL=(ALL) NOPASSWD:ALL',
  }

  file { '/etc/update-motd.d':
    purge => true
  }

  ufw::allow { 'allow-ssh-from-all':
    port => 22,
    ip   => 'any',
  }

}
