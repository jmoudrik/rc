# /etc/skel/.bashrc:

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]]; then
	# Shell is non-interactive.  Be done now
	return
fi

export LS_COLORS="$LS_COLORS:di=1;33:"

alias umount_remote="fusermount -u /home/jm/remote"
alias su="sudo bash"

alias gk="gitk"
alias ga="git add"
alias gb="git branch"
alias gc="git checkout"
alias gd="git diff"
alias gg="git gui"
alias gh="git stash"
alias gl="git log"
alias gp="git pull"
alias gs="git status"
alias gt="git commit"
alias gu="git push"

alias xv='sxiv'
alias cal="ncal -M"
alias pdfgrep="pdfgrep -n"
alias grep="grep --color=auto"
alias txts="txts --color-always -R"

alias ssh_tunel="autossh -D 127.0.0.1:10003 j2m -N &"
alias cdms="cd /home/jm/remote/afs/ms/u/m/moudj6am/"

alias seznam="ping www.seznam.cz"
alias ls="ls -X --color=auto"
alias ll="ls -l"
alias lt="ls -lt"
alias gvim="gvim -p"
alias vim="vim -p"
alias vi="vim -p"

export NNN_CONTEXT_COLORS='3333'
alias n='nnn'

#ulimit -c unlimited

export HISTSIZE=-1
export HISTFILESIZE=-1

LGREY='\[\033[1;37m\]'
GREY_RAW='\033[0;37m'
GREY='\['$GREY_RAW'\]'
DGREY='\[\033[1;30m\]'
CYAN_RAW='\033[0;36m'
CYAN='\['$CYAN_RAW'\]'
LCYAN_RAW='\033[1;36m'
LCYAN='\['$LCYAN_RAW'\]'
REDB_RAW='\033[1;31m'
REDB='\['$REDB_RAW'\]'
RED_RAW='\033[0;31m'
RED='\['$RED_RAW'\]'
GREEN_RAW='\033[0;32m'
GREEN='\['$GREEN_RAW'\]'
GREENB_RAW='\033[1;32m'
GREENB='\['$GREENB_RAW'\]'
DEF_RAW='\033[0m'
DEF='\['$DEF_RAW'\]'
DEFB_RAW='\033[1m'
DEFB='\['$DEFB_RAW'\]'
YELLOW_RAW='\033[1;33m'
YELLOW='\['$YELLOW_RAW'\]'
BROWN='\[\033[0;33m\]'
LPURPLE='\[\033[1;35m\]' #bleeeeeeee
PURPLE_RAW='\033[0;35m'
PURPLE='\['$PURPLE_RAW'\]'

NICKCOLOR="$CYAN"
[ "$(whoami)" = 'root' ] && NICKCOLOR="$REDB"

MASHINECOLOR="$YELLOW"

case $(hostname) in
	kolotoc ) MASHINECOLOR="$LCYAN" ;;
	cervotoc ) MASHINECOLOR="$PURPLE" ;;
esac

both () {
	[ "$1" -gt 0 ] && echo "$2$1"
}

one () {
	[ "$1" -gt 0 ] && echo "$2"
}

fixup_remote () {
[ "$1" != "." ] && echo " $1" | sed 's/_NO_REMOTE_TRACKING_/local/;s/_BEHIND_/↓/;s/_AHEAD_/↑/'
}
fixup_branch () {
	echo "$1" | sed 's/_PREHASH_/#/;s/^\(.\{20\}\)\(...\).*$/\1…/;s/^\(feature\|FEATURE\)/F/'
}

ps_git () {
status=$(gitstatus.sh 2>/dev/null)

if [ "$?" -eq 0 ] ; then
	echo "$status" | { 
		read branch
		read remote
		read upstream
		read num_staged
		read num_conflicts
		read num_changed
		read num_untracked
		read num_stashed
		read clean

		branch="$(fixup_branch "$branch")"
		remote="$(fixup_remote "$remote")"
		#branch_symbol=$([ -n "$branch" ] && echo "𐌖 ")
		branch_symbol=
		echo -e " $GREY_RAW($PURPLE_RAW$branch_symbol$CYAN_RAW$branch$PURPLE_RAW$remote $REDB_RAW$(both $num_conflicts "x")$GREENB_RAW$(both $num_staged "●")$RED_RAW$(both $num_changed "+")$GREY_RAW$(both $num_stashed "⚑")$GREENB_RAW$(one "$clean" ✔)$GREY_RAW$(both "$num_untracked" …)$GREY_RAW)"
	}
fi
}

PS_STATS=''
[ -n "$MC_SID" ] && PS_STATS=" $RED(mc)$PS_STATS"
echo $TERM | grep "screen" >/dev/null && PS_STATS=" $PURPLE(screen)$PS_STATS"
[ -n "$SSH_CLIENT" ] && PS_STATS=" $GREY(${CYAN}ssh from ${LCYAN}$(echo $SSH_CLIENT | sed 's/^\([^ ]*\) .*$/\1/')$GREY)$PS_STATS"

export PS1=" $NICKCOLOR\u $LCYAN\j$GREY${PS_STATS} $GREY[${LCYAN}\$(date +%k:%M:%S)$GREY] [$LCYAN\w$GREY]\$(ps_git)
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
