
class users::main::kurgan {
  user { "kurgan":
        ensure   => "present",
        groups   => "admin",
        comment => "il ne peut en rester qu'un",
        shell    => "/bin/zsh",
    }
   
    file {"/home/kurgan/.zshrc":
         ensure => present,
         source => "puppet:///users/homes/kurgan/.zshrc",
         require => User["kurgan"]
    }
}
