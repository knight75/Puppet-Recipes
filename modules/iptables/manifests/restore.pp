/*

handle file iptables.rules
restore only if file has been modified

*/

class iptables::restore {

           file {"/etc/network/iptables.rules":
                  ensure => present,
                  owner => root,
                  group => admins,
                  mode => 640,
                  source => "puppet:///modules/iptables/iptables.rules"
               }

           exec {"iptables-restore < /etc/network/iptables.rules":
                  subscribe => File["/etc/network/iptables.rules"],
                  refreshonly => true,
                  require => File["/etc/network/iptables.rules"],
               }
}
