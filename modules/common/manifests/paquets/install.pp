

class common::paquets::install {
        package {"zsh":
                ensure => installed
        }

        package {"vim-common":
                ensure => installed
        }

        package {"vim-puppet":
                ensure => installed
        }

        package {"libshadow-ruby1.8":
                ensure => installed
        }

        package {"less":
                ensure => installed
        }

        package {"mlocate":
                ensure => installed
        }

}
