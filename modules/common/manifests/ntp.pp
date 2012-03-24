

class common::ntp {

#syncro ntp uniquement pour les machines physiques
     case $is_virtual {
       'false': {include common::ntp::ntpconf}
        default: {}
}


}
