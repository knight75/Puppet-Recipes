/*

Install and configure ssh

*/

class common::ssh {
   $package = $operatingsystem ? {
    redhat => openssh,
    CentOS => openssh,
    default => openssh-client
    }

   $package1="openssh-server"
   $service = $operatingsystem ? {
    redhat => sshd,
    CentOS => sshd, 
    default => ssh 
  }
 
  package { $package:
    ensure => installed,
  }

  package { $package1:
    ensure => installed,
  }

  file { "/etc/ssh/ssh_config":
    source => ["puppet:///common/ssh/ssh_config.$hostname","puppet:///common/ssh/ssh_config"],
    owner => root,
    group => admins,
    mode => 644,
    backup => ".backup-puppet",
    notify => Service[$service],
    require  => Package[$package]
   } 

   file { "/etc/ssh/sshd_config":
    source => ["puppet:///common/ssh/sshd_config.$hostname","puppet:///common/ssh/sshd_config"],
    owner => root,
    group => admins,
    mode => 644,
    backup => ".backup-puppet",
    notify => Service[$service],
    require  => Package[$package]
   }

   file { "/etc/ssh/KEYS":
     owner => "root",
     group => "root",
     ensure => directory
   }


  service { "$service":
    ensure   => "running",
    restart  => "/etc/init.d/$service restart",
    name     => "$service",
    path     => "/etc/init.d",
    pattern  => "$service",
   subscribe => [Package[$package], File["/etc/ssh/ssh_config"], File["/etc/ssh/sshd_config"]]
  } 
}

