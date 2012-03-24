################################################
#Fichier deploye par puppet
#Ne pas faire de modification locale
###############################################
verif= %x(ifconfig eth0 | grep -Eo "MTU:[0-9]+"|cut -d":" -f 2).to_i
Facter.add(:jumbo_frames) do
        if verif >= 1500
            setcode { "enabled" }
        else
            setcode { "disabled" }
        end
end
