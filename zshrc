#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
source /etc/zsh/prezto/init.zsh

function exists() {
	type $* >/dev/null 2>&1
}

alias x="exit"

if exists pydf; then
	alias df="pydf -Bh"
fi

alias du="du -hs"
alias l='ls -Flh --color=auto --group-directories-first'
alias la='ls -la --color=auto --group-directories-first'
alias lad='ls -d .*(/) --group-directories-first'
alias lh='ls -hAl --color=auto --group-directories-first'
alias ll='ls -l --color=auto --group-directories-first'
alias ln='ln -i --group-directories-first'
alias ls='ls -b -CF --color=auto --group-directories-first'
alias lsa='ls -a .*(.) --group-directories-first'
alias lsbig='ls -flh *(.OL[1,10]) --group-directories-first'
alias lsd='ls -d *(/) --group-directories-first'
alias lse='ls -d *(/^F) --group-directories-first'
alias lsl='ls -l *(@) --group-directories-first'
alias lsnew='ls -rtlh *(D.om[1,10]) --group-directories-first'
alias lsnewdir='ls -rthdl *(/om[1,10]) .*(D/om[1,10]) --group-directories-first'
alias lsold='ls -rtlh *(D.Om[1,10]) --group-directories-first'
alias lsolddir='ls -rthdl *(/Om[1,10]) .*(D/Om[1,10]) --group-directories-first'
alias lss='ls -l *(s,S,t) --group-directories-first'
alias lssmall='ls -Srl *(.oL[1,10]) --group-directories-first'
alias lsw='ls -ld *(R,W,X.^ND/) --group-directories-first'
alias lsx='ls -l *(*) --group-directories-first'

alias cl="clear"

if exists colordiff; then
	alias diff="colordiff -u"
else
	alias diff="diff -u"
fi

if exists rsync; then
	alias rs="rsync -ahHPv"
	alias exfat-rsync='command rsync -rLvW --size-only --delete'
fi

alias mv="mv -i"
alias cp="cp -i"
alias ln="ln -i"
alias rm="rm -I --preserve-root"
alias chown="chown --preserve-root"
alias chmod="chmod --preserve-root"
alias chgrp="chgrp --preserve-root"

alias shutdown="sudo shutdown"
alias reboot="sudo reboot"
alias poweroff="sudo poweroff"

alias cpuinfo="lscpu"
alias meminfo="free -m -l -t"
alias psmem="ps auxf | sort -nr -k 4"
alias pscpu="ps auxf | sort -nr -k 3"

if exists wget; then
	alias wget="wget -c"
fi

if exists htop; then
	alias top="htop"
fi

alias pacman="sudo pacman"
alias p="sudo pacman"
alias y="yaourt"
alias ctrl="systemctl"
alias mp="mplayer"
if exists cower; then
	alias cower='cower --color=auto'
fi
if exists tlp-stat; then
	alias batt='sudo tlp-stat -b'
fi
if exists perl-rename; then
	alias perl-rename='perl-rename -i'
	alias prename='perl-rename -i'
fi
alias encrypt='openssl enc -a -salt -aes-256-cbc'
alias decrypt='encrypt -d'
if exists systemctl; then
	alias start='sudo systemctl start'
	alias stop='sudo systemctl stop'
	alias restart='sudo systemctl restart'
	alias status='sudo systemctl status'
fi
alias pa-speaker="pactl set-sink-port 0 analog-output-speaker"
alias pa-dock="pactl set-sink-port 0 analog-output"
alias pa-headphones="pactl set-sink-port 0 analog-output-headphones"
if exists hub; then
	alias git=hub
fi
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias -g S='>/dev/null 2>&1 &'

if exists okular; then
	alias -s pdf="okular"
	function okular  { command okular  $* >/dev/null 2>&1 &; }
fi
if exists ncmpcpp; then
	alias mpd="ncmpcpp"
	alias mpc="ncmpcpp"
	alias now-playing="ncmpcpp --now-playing"
fi
if exists dolphin; then
	function dolphin { command dolphin $* >/dev/null 2>&1 &; }
fi

function uml {
	cat $1 | plantuml -tsvg -p | inkscape --without-gui --export-pdf=/dev/stdout /dev/stdin 2>/dev/null >! $(basename $1 .txt).pdf
}

function calc() {
	echo $(($*));
}

function json-get() {
	curl -s "$1" | python -m json.tool
}

if exists xmllint; then
	function format-xml() {
		T=$(tempfile)
		cat $1 > $T
		xmllint --format $T > $1
		rm -f $T
	}
fi

if exists psql; then
	function create_database {
		psql -U postgres -c "DROP DATABASE IF EXISTS $1;"
		psql -U postgres -c "CREATE DATABASE $1;"
		psql -U postgres -d $1 -c "CREATE EXTENSION postgis;"
	}
fi

if exists rdesktop; then
	if exists pass; then
		function rdesktop {
			local _user _host _domain
			IFS=@ read _user _host <<< "${1}"
			IFS=\\ read _domain _user <<< "${_user}"
			echo -E command rdesktop -k de -T "$1" -g '1680x1050' -u "${_domain:+${_domain}\\\\}${_user}" -p $(pass show Remote/${_host}/${_domain:+${_domain}/}${_user}) ${_host}
			command rdesktop -k de -T "$1" -g '1680x1050' -u "${_domain:+${_domain}\\}${_user}" -p $(pass show Remote/${_host}/${_domain:+${_domain}/}${_user}) ${_host}
		}
	fi
fi

cdpath=('.' '..' '~' '/media' /var/run/media/$USER)
zstyle ':completion:*:complete:(cd|pushd):*' tag-order \
	'local-directories named-directories path-directories'
zstyle ':completion:*' group-name ''


setopt localoptions nonomatch
