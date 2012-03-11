/*

Install molly-guard
Deploy a default file wich content is a template

*/

class common::mollyguard::debian {

             package { "molly-guard":
                        ensure => installed,
                     }

             file { "/etc/molly-guard/messages.d/default":
                     ensure => "present",
                     owner => "root",
                     group => "root",
                     mode  => 644,
                     require => Package['molly-guard'],
                     content => template("common/mollyguard/default.erb"),
                  }
}

