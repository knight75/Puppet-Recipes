#########################################                                                                                                                                                                     
#Fichier deploye par puppet
#Ne pas faire de modification locale
#########################################

#le node est il un node oracle ou non?

Facter.add(:is_oracle) do
         orafile = "/etc/oratab"

  setcode do
         if File.exists?(orafile)
	       	 is_oracle = true
	 else
	       	 is_oracle = false
	 end
  end
end
