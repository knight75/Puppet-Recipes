##############################################
#Fichier deploye par puppet
#Ne pas faire de modifications locales
##############################################

Facter.add("virtual") do
  confine :kernel => %w{Linux FreeBSD OpenBSD}
  
  ENV["PATH"]="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/sbin:/usr/local/bin"
  
  result = "physical"
  
  setcode do 

    if FileTest.exists?("/proc/user_beancounters")
      result = "openvz"
    end

    if FileTest.exists?("/proc/sys/xen/independent_wallclock")
      result = "xenu"
    elsif FileTest.exists?("/proc/xen/capabilities")
      txt = File.read("/proc/xen/capabilities")
      if txt =~ /control_d/i
        result = "xen0"
      end
    end

    if result == "physical"
      lspciexists = system "which lspci > /dev/null 2>&1"
      if $?.exitstatus == 0
        output = %x{lspci}
        output.each {|p|
          # --- look for the vmware video card to determine if it is virtual => vmware.
          # ---     00:0f.0 VGA compatible controller: VMware Inc [VMware SVGA II] PCI Display Adapter
          result = "vmware" if p =~ /VM[wW]are/
        }
      else
        dmidecodeexists = system "which dmidecode > /dev/null 2>&1"
        if $?.exitstatus == 0
          outputd = %x{dmidecode}
          outputd.each {|pd|
            result = "vmware" if pd =~ /VMware|Parallels/
          }
        end
      end
    end

    # VMware server 1.0.3 rpm places vmware-vmx in this place, other versions or platforms may not.
    if FileTest.exists?("/usr/lib/vmware/bin/vmware-vmx")
      result = "vmware_server"
    end

    mountexists = system "which mount > /dev/null 2>&1"
    if $?.exitstatus == 0
      output = %x{mount}
      output.each {|p|
        result = "vserver" if p =~ /\/dev\/hdv1/
      }
    end

    if FileTest.directory?('/proc/virtual')
      result = "vserver_host"
    end

    result
  end
end

Facter.add("is_virtual") do                                                                                                                                                                                    
    confine :kernel => %w{Linux FreeBSD OpenBSD SunOS}

    setcode do
        case Facter.value(:virtual)
        when "xenu", "openvzve", "vmware"
            true
        else
            false
        end
    end
end
