################################################
#Fichier deploye par puppet
#Ne pas faire de modification locale
###############################################

#thanks to  R.I PIENAAR

Facter.add(:puppet_enabled) do
    lockfile = "/var/lib/puppet/state/puppetdlock"

    if File.exists?(lockfile)
        # if the lock file exist and has no PID in it, then puppetd is
        # disabled, if there's a PID then its running or dead unexpectedly
        if File::Stat.new(lockfile).zero?
            setcode { "enabled" }
        else
            setcode { "disabled" }
        end
    else
        setcode { "enabled" }
    end
end
