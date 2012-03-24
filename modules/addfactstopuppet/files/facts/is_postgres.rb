#########################################                                                                                                                                                                     
#Fichier deploye par puppet
#Ne pas faire de modification locale
#########################################

#le node est il un nopde oracle ou non?

Facter.add(:is_postgres) do

  setcode do
          if %x(locate postgresql.conf >/dev/null 2>/dev/null; echo $?).chomp == "0"
	       	 is_postgres = true
	 else
	       	 is_postgres = false
	 end
  end
end
