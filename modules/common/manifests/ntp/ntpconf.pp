class common::ntp::ntpconf {

   $service = $operatingsystem ? {
    redhat => ntpd,
    default => ntp 
  }

   package { "ntp":
     ensure => installed 
   }

   file { "/etc/ntp.conf":
   source => ["puppet:///common/ntp/ntp.conf.$operatingsystem", "puppet:///common/ntp/ntp.conf"],
   ensure => present,
   require => Package["ntp"],
   notify => Service[$service]
   }

   service { "$service":
     ensure => running,
     enable => true,
     name     => $service,
     path     => "/etc/init.d",
     restart  => "/etc/init.d/$service restart",
     pattern  => "$service"
  }
}
