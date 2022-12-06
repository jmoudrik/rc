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
alias num_stats='python3 -m jmpy.num_stats'

alias ssh_tunel="autossh -D 127.0.0.1:10003 j2m -N &"
alias cdms="cd /home/jm/remote/afs/ms/u/m/moudj6am/"

alias seznam="ping www.seznam.cz"
alias ls="ls -X --color=auto"
alias ll="ls -l"
alias lt="ls -lt"

alias jsp='python -m json.tool'
alias strip="sed 's/^[[:space:]]*//;s/[[:space:]]*$//'"

set completion-ignore-case on


lth () {
	ls -lt "$@" | head -n 20
}

box () {
	echo "#######################################"
	echo "# ""$@"
	echo "#######################################"
}

alias gvim="gvim -p"
alias vim="vim -p"
alias vi="vim -p"
alias parallel="parallel --citation"
alias mc='n'

ulimit -c unlimited

export HISTSIZE=-1
export HISTFILESIZE=-1

alias nnn='nnn -cRdE'
#export NNN_OPENER="batcat --paging always"
export NNN_OPENER="/home/jm/.config/nnn/plugins/jm_open"
export NNN_CONTEXT_COLORS='3333'
export NNN_FCOLORS='c1e2272e006033f7c6d6abc4'
export NNN_COLORS='#b9cb2c45'
export NNN_FIFO="/tmp/nnn.fifo"
export NNN_PLUG='t:!th;d:jm_diffs;i:imgview;c:jm_fzcd;z:jm_autojump;h:fzhist;p:preview-tui'

n ()
{
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # To cd on quit only on ^G, either remove the "export" as in:
    #    NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    #    (or, to a custom path: NNN_TMPFILE=/tmp/.lastd)
    # or, export NNN_TMPFILE after nnn invocation
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}



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
		echo -e " $GREY_RAW($PURPLE_RAW$branch_symbol$CYAN_RAW$branch$PURPLE_RAW$remote $REDB_RAW$(both $num_conflicts "x")$GREENB_RAW$(both $num_staged "●")$RED_RAW$(both $num_changed "+")$GREY_RAW$(both $num_stashed "⚑ ")$GREENB_RAW$(one "$clean" ✔)$GREY_RAW$(both "$num_untracked" …)$GREY_RAW)"
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
