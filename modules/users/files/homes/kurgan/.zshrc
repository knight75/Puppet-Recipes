HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000

#print the name of the remote host in the head of the xterm
case $TERM in
    xterm*)
        precmd () {print -Pn "\e]0;%n@%m: %~\a"}
        ;;
esac

#bindkey -v
bindkey '^[[3~' delete-char
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'
#autoload -Uz compinit
autoload -U compinit
compinit

autoload -U promptinit
promptinit

prompt adam1

# End of lines added by compinstall
zstyle :compinstall filename '/home/kurgan/.zshrc'
clear
salut="Bonjour $USER !\nBienvenue sur $HOST !\nNous sommes le $(date) !\nJe te souhaite bon courage "
echo -e $salut

# My own options (see man zshoptions)
setopt auto_cd
setopt auto_pushd
setopt cdable_vars
CDPATH=$CDPATH:$HOME
PATH_DIRS=$PATH_DIRS:$HOME/scripts
setopt pushd_ignore_dups
setopt hist_ignore_dups
setopt inc_append_history
setopt extended_history
#setopt path_dirs
setopt correct
setopt nonomatch
setopt extended_glob
NULLCMD=:

          # Personal aliases
vi() {
  if [ -w $1 ]; then
    command vim $*
  elif [ ! -e $1 ] && [ -w $(dirname $1) ]; then
    command vim $*
  else
    command sudo -e $*
  fi
}
#alias man='man -a'
alias sudo='command sudo '
alias machinespuppetisees='sudo /opt/scripts/puppet/machines_puppetisees.sh'
alias hostpuppetise='sudo /opt/scripts/puppet/hostpuppetise.sh'

# Environment variables
export GIT_EDITOR=vi
export SUDO_EDITOR=vi
export EDITOR=vi


# Automatic files handling
autoload zsh-mime-setup
zsh-mime-setup 2>/dev/null


# Completion development lines
# => be as verbose as possible
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''

