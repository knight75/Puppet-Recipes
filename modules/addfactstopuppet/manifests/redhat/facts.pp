class addfactstopuppet::redhat::facts {

case $lsbdistid {

  RedHatEnterpriseES, RedHatEnterpriseAS: {
       file {"/usr/lib64/site_ruby/1.8/facter":
              ensure => "directory",
              owner => "root",
              group => "root",
              recurse => true,
              source => "puppet:///addfactstopuppet/facts"
             }
  }

  default: {
   file {"/usr/lib/ruby/site_ruby/1.8/facter":
              ensure => "directory",
              owner => "root",
              group => "root",
              recurse => true,
              source => "puppet:///addfactstopuppet/facts"
             }
  }

 }
}
