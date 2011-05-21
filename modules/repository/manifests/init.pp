#thanks to puppetlabs site
#http://projects.puppetlabs.com/projects/1/wiki/Apt_Keys_Patterns

define aptkey($keyid, $ensure, $keyserver = "keyserver.ubuntu.com", $debiankeyserver = "http://keyring.debian.org") {
        case $ensure {
                present: {
                        exec { "Import $keyid to apt keystore":
                                environment => "HOME=/root",
                                command     => "apt-key adv --keyserver $keyserver --recv-keys $keyid && sudo apt-get update",
                                user        => "root",
                                group       => "root",
                                unless      => "apt-key list | grep $keyid",
                                logoutput   => on_failure,
                        }
                }
                absent:  {
                        exec { "Remove $keyid from apt keystore":
                                path    => "/bin:/usr/bin",
                                environment => "HOME=/root",
                                command => "apt-key del $keyid",
                                user    => "root",
                                group   => "root",
                                onlyif  => "apt-key list | grep $keyid",
                        }
                }
                default: {
                        fail "Invalid 'ensure' value '$ensure' for apt::key"
                }
        }
}


class repository {
            include repository::specialrepositories


}
