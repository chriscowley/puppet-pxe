class pxe {
  case $operatingsystem {
    centos, redhat: {
      $packages = [ 'syslinux.x86_64', 'tftp-server.x86_64', ]
    }
  }
  package { $packages:
    ensure => latest,
  }
  exec { "create_tftpboot_dir":
    command => "cp -a /usr/share/syslinux/ /tftpboot",
    creates =>  "/tftpboot",
    path    => ["/bin"],
  }
  file { ["/tftpboot/pxelinux.cfg", "/tftpboot/images"]:
    ensure  => directory,
    require => Exec["create_tftpboot_dir"],
  }
}
