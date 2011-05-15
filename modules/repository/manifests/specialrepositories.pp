#managing special repositories

class repository::specialrepositories {
            aptkey { "98AB5139":
                keyid  => "98AB5139",
                ensure => present
            }

            file {"/etc/apt/sources.list.d/virtualbox.list":
                 ensure => present,
                 content => template("repository/virtualbox.erb"),
                 notify => Exec["refresh_apt"],
                 require => Aptkey[98AB5139]
            }

            exec {"refresh_apt":
                 command => "apt-get update",
                 subscribe   => File["/etc/apt/sources.list.d/virtualbox.list"] 
            }
}
