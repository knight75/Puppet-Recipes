class common::crons {
        file { "/etc/cron.d":
                ensure => directory,
                owner => root,
                group => root,
                sourceselect => all,
                source => ["puppet:///files/crons/$hostname", "puppet:///files/crons/ALL"],
                recurse => true,
                replace => true
        }
}
