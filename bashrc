# /etc/skel/.bashrc:

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]]; then
	# Shell is non-interactive.  Be done now
	return
fi

alias umount_remote="fusermount -u /home/jm/remote"
alias su="sudo -H bash"
alias cal="ncal -M"
alias pdfgrep="pdfgrep -n"
alias grep="grep --color=auto"
alias txts="txts --color-always -R"

alias ssh_tunel="ssh -D 127.0.0.1:10003 j2m -N -v"
alias cdms="cd /home/jm/remote/afs/ms/u/m/moudj6am/"
alias cdu="cd /home/jm/remote/WWW/vyuka/unix2017"
alias cdp=". ~/bin/cdp.sh"

alias seznam="ping www.seznam.cz"
alias ls="ls -X --color=auto"
alias ll="ls -l"
alias lt="ls -lt"
alias gvim="gvim -p"
alias vim="vim -p"
alias vi="vim -p"

#ulimit -c unlimited

export HISTSIZE=-1
export HISTFILESIZE=-1

LGREY='\[\033[1;37m\]'
GREY='\[\033[0;37m\]'
DGREY='\[\033[1;30m\]'
CYAN='\[\033[0;36m\]'
LCYAN='\[\033[1;36m\]'
RED='\[\033[1;31m\]'
DEF='\[\033[0m\]'
YELLOW='\[\033[1;33m\]'
BROWN='\[\033[0;33m\]'
LPURPLE='\[\033[1;35m\]' #bleeeeeeee
PURPLE='\[\033[0;35m\]'

NICKCOLOR=$CYAN
[ "$(whoami)" = 'root' ] && NICKCOLOR=$RED

MASHINECOLOR=$YELLOW

case $(hostname) in
	kolotoc ) MASHINECOLOR=$LCYAN ;;
	cervotoc ) MASHINECOLOR=$PURPLE ;;
esac

PS_STATS=''
[ -n "$MC_SID" ] && PS_STATS=" $RED(mc)$PS_STATS"
echo $TERM | grep "screen" >/dev/null && PS_STATS=" $PURPLE(screen)$PS_STATS"
[ -n "$SSH_CLIENT" ] && PS_STATS=" $GREY(${CYAN}ssh from ${LCYAN}$(echo $SSH_CLIENT | sed 's/^\([^ ]*\) .*$/\1/')$GREY)$PS_STATS"

export PS1="  $GREY($NICKCOLOR\u $GREY@ $MASHINECOLOR\h$GREY)${PS_STATS} $GREY[${LCYAN}\$(date +%k:%M:%S)$GREY] [${CYAN}jobs $LCYAN\j$GREY] [$LCYAN\w$GREY]
$GREY "'\$'" $DEF"

# MC=''
# [ -n "$(env | grep MC_SID)" ] && MC=" $RED(MC)"

d=.dircolors
test -r $d && eval "$(dircolors $d)"

# uncomment the following to activate bash-completion:
[ -f /etc/bash-completion ] && source /etc/bash-completion

# nastavit jmeno okna terminalu
#
#thc () {
#	ret=$( trap | grep 'DEBUG$' )
#	[ -n "$ret" ] && { echo "Removing following trap:" $ret >&2 ; trap - DEBUG ; }
#
#	echo -n -e "\033]0;$@\007"
#}
