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
alias ctrl="systemctl"
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias -g S='>/dev/null 2>&1 &'

if exists mpv; then
	alias mp="mpv"
	alias mplayer="mpv"
fi

if exists colordiff; then
	alias diff="colordiff -u"
else
	alias diff="diff -u"
fi

if exists rsync; then
	alias rs="rsync -ahHPv"
	alias exfat-rsync='command rsync -rLvW --size-only --delete'
fi

if exists wget; then
	alias wget="wget -c"
fi

if exists htop; then
	alias top="htop"
fi

if exists pacman; then
	alias pacman="sudo pacman"
	alias p="sudo pacman"
fi

if exists yaourt; then
	alias y="yaourt"
fi


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

if exists openssl; then
	alias encrypt='openssl enc -a -salt -aes-256-cbc'
	alias decrypt='encrypt -d'
fi

if exists systemctl; then
	alias start='sudo systemctl start'
	alias stop='sudo systemctl stop'
	alias restart='sudo systemctl restart'
	alias status='sudo systemctl status'
	alias enable='sudo systemctl enable'
	alias disable='sudo systemctl disable'
fi

if exists pactl; then
	alias pa-speaker="pactl set-sink-port 0 analog-output-speaker"
	alias pa-dock="pactl set-sink-port 0 analog-output"
	alias pa-headphones="pactl set-sink-port 0 analog-output-headphones"
fi

if exists hub; then
	alias git=hub
fi

if exists okular; then
	for t in {p,P}{d,D}{f,F}; do
		alias -s $t="okular"
	done
	function okular { command okular $* >/dev/null 2>&1 &; }
elif exists evince; then
	for t in {p,P}{d,D}{f,F}; do
		alias -s $t="evince"
	done
	function evince { command evince $* >/dev/null 2>&1 &; }
fi

if exists eog; then
	for t in {j,J}{p,P}{,{e,E}}{g,G} {p,P}{n,N}{g,G} {g,G}{i,I}{f,F} {b,B}{m,M}{p,P}; do
		alias -s $t="eog"
    done
	function eog { command eog $* >/dev/null 2>&1 &; }
fi


if exists ncmpcpp; then
	alias mpd="ncmpcpp"
	alias mpc="ncmpcpp"
	alias now-playing="ncmpcpp --now-playing"
fi

if exists dolphin; then
	function dolphin { command dolphin $* >/dev/null 2>&1 &; }
elif if exists nautilus; then
	function nautilus { command nautilus $* >/dev/null 2>&1 &; }
fi

if exists plantuml; then
    function uml {
	    cat $1 | plantuml -tsvg -p | inkscape --without-gui --export-pdf=/dev/stdout /dev/stdin 2>/dev/null >! $(basename $1 .txt).pdf
    }
fi

function calc() {
	echo $(($*));
}

if exists pygmentize; then
	function json-get() {
		curl -s '$1' | python -m json.tool | pygmentize -l json
	}
else
	function json-get() {
		curl -s "$1" | python -m json.tool
	}
fi

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

if exists docker; then
	function docker-update {
		docker image ls --format '{{.Repository}}:{{.Tag}}' | grep -v ':<none>$' | parallel docker image pull
		docker image prune -f
	}
fi

if exists rdesktop; then
	if exists pass; then
		function rdesktop {
			local _user _host _domain
			IFS=@ read _user _host <<< "${1}"
			IFS=\\ read _domain _user <<< "${_user}"
			if [ -z "${_user}" ]; then
				_user=${_domain}
				_domain=
			fi
			command rdesktop -k de -T "$1" -f -u "${_domain:+${_domain}\\}${_user}" -p $(pass show Remote/${_host}/${_domain:+${_domain}/}${_user}) ${_host}
		}
	fi
fi
