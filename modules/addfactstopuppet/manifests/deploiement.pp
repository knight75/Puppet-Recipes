
class addfactstopuppet::deploiement {
         case $operatingsystem {
              Debian, debian: {include addfactstopuppet::debian::facts, addfactstopuppet::debian::debianfacts}
              RedHat, redhat: {include addfactstopuppet::redhat::facts}
              default:{}
           }
}
