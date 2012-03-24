##########################################
#Fichier deploye par puppet
#Ne pas faire de modification locale
#########################################

#La machine est elle un serveur webdomain ou non?

Facter.add(:is_webdomain) do
  setcode do
    if Facter.value(:ipaddress) !~ /127.0.0.1/
      is_webdomain = false
    elsif Facter.value("hostname") =~ /^toto-|vm-toto/
      is_webdomain = false
    else
      is_webdomain = true
    end                                                                                                                                                                                                        
  end
end

