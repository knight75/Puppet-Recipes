/*

Install Pacemaker

*/

class pacemaker::install {
              package {"pacemaker":
                       ensure=> installed
              }

              file {"/etc/corosync/authkey":
                       ensure => present,
                       mode => 400,
                       owner => root,
                       group => root,
                       source => "puppet:///modules/pacemaker/install/authkey",
                       require => Package["pacemaker"]
                   }

              file {"/etc/corosync/corosync.conf":
                       ensure => present,
                       mode => 644,
                       owner => root,
                       group => root,
                       source => "puppet:///modules/pacemaker/install/corosync.conf",
                       require => File["/etc/corosync/authkey"]
                   }

              exec { "enable_pacemaker_at_boot":
                       command => "sed -i 's/START=no/START=yes/g' /etc/default/corosync",
                       unless => "grep START=yes /etc/default/corosync",
                       require => [File["/etc/corosync/corosync.conf"]],
                       notify => Exec["start_corosync"]
                  }

              exec { "start_corosync":
                       command => "/etc/init.d/corosync start",
                       unless => "grep START=yes /etc/default/corosync",
                       require => Exec["enable_pacemaker_at_boot"],
                  }


}
