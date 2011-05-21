###########################################################################
#Definitions used to manage files
#Ensure a line is present or not
#Replace parts of text
#Thanks to http://projects.puppetlabs.com/projects/1/wiki/Simple_Text_Patterns
###########################################################################

define line($file, $line, $ensure = 'present') {
    case $ensure {
        default : { err ( "unknown ensure value ${ensure}" ) }
        present: {
            exec { "/bin/echo '${line}' >> '${file}'":
                unless => "/bin/grep -qFx '${line}' '${file}'"
            }
        }
        absent: {
            exec { "/usr/bin/perl -ni -e 'print unless /^\\Q${line}\\E\$/' '${file}'":
                onlyif => "/bin/grep -qFx '${line}' '${file}'"
            }
        }

       uncomment: {
            exec { "/bin/sed -i -e'/${line}/s/^#\+//' '${file}'":
                onlyif => "/bin/grep '${line}' '${file}' | /bin/grep '^#' | /usr/bin/wc -l"
            }
        }

        comment: {
            exec { "/bin/sed -i -e'/${line}/s/^\(.\+\)$/#\1/' '${file}'":
                onlyif => "/usr/bin/test `/bin/grep '${line}' '${file}' | /bin/grep -v '^#' | /usr/bin/wc -l` -ne 0"
            }
       }
    }
}

define ensure_key_value($file, $key, $value, $delimiter = " ") {
    # append line if "$key" not in "$file"
    exec { "append $key$delimiter$value $file":
        command => "echo '$key$delimiter$value' >> $file",
        unless => "grep -qe '^[[:space:]]*$key[[:space:]]*$delimiter' -- $file",
        path => "/bin:/usr/bin:/usr/local/bin",
        before => Exec["update $key$delimiter$value $file"],
    }

    # update it if it already exists...
    exec { "update $key$delimiter$value $file":
        command => "sed --in-place='' --expression='s/^[[:space:]]*$key[[:space:]]*$delimiter.*$/$key$delimiter$value/g' $file",
        unless => "grep -xqe '$key$delimiter$value' -- $file",
        path => "/bin:/usr/bin:/usr/local/bin"
    }
}
