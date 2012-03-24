class addfactstopuppet::debian::debianfacts {
  if $facterversion <= '1.5.1' {
  file {"/usr/lib/ruby/1.8/facter/virtual.rb":
         ensure => "present",
         owner => "root",
         group => "root",
         mode => "644",
         source => "puppet:///addfactstopuppet/debianfacts/virtual.rb"
  }
 }
}
