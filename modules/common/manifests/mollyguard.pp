/*

A molly-guard package is only present for debian nodes
Will try to make a redhat one one day

*/

class common::mollyguard {

  case $operatingsystem {
         debian: {include common::mollyguard::debian}
         default: {}
    }

}
