##########################################
#Fichier deploye par puppet
#Ne pas faire de modification locale
#########################################

# Jean-Baptiste BARTH - 05/01/2012
# <jeanbaptiste.barth@gmail.com>
#
# make a unique ID
# because of vm cloning, 2 hosts can have the same  hostid or sshrsakey/sshdsakey
# in our cmdb, each host have to be unique.

Facter.add(:puppetid) do
  setcode do
    #if /etc/puppetid exists, read it
    puppetid = File.read("/etc/puppet/puppetid").strip rescue nil
    #if not, try to set it
    if puppetid.nil? || !puppetid.match(/^\S{64}$/)
      #See: http://aremark.concept-in.org/2009/08/random-hex-string-generator-in-ruby.html
      length = 64
      puppetid = ((0..length).map{rand(256).chr}*"").unpack("H*")[0][0,length]
      File.open("/etc/puppet/puppetid","w") do |f|
        f.write(puppetid)
      end
    end
    puppetid
  end
end

