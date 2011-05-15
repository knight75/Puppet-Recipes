###############
#default node basis instruction
###############################
import "nodes"


#general export
Exec { path => "/usr/bin:/usr/sbin/:/bin:/sbin" }

#define default package provider depending on the os
Package {
    provider => $operatingsystem ? {
        Debian => apt,
        Ubuntu => apt,
        CentOs => yum
    }
}

