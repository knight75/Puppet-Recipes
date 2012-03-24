class addfactstopuppet::debian::facts {

case $architecture {

  amd64: {
   file {"/usr/lib64/ruby/1.8/facter":
              ensure => "directory",
              owner => "root",
              group => "root",
              recurse => true,
              source => "puppet:///addfactstopuppet/facts/"
             }
  }

  default: {
       file {"/usr/lib/ruby/1.8/facter":
              ensure => "directory",
              owner => "root",
              group => "root",
              recurse => true,
              source => "puppet:///addfactstopuppet/facts/"
           }
  }
 }
}
