/*

be sure to compress all logs in logrotate

*/


class common::logrotate {
              exec {"compress_logrotates":
                    command => 'sed -i "s/#compress/compress/" /etc/logrotate.conf',
                    onlyif => 'grep -Fis "#compress" /etc/logrotate.conf'
               }


}
