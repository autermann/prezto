#G
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
source /etc/zsh/prezto/init.zsh

alias x="exit"
alias df="pydf -Bh"
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
alias diff="colordiff -u"
alias rs="rsync -ahHPv"
alias exfat-rsync='command rsync -rLvW --size-only --delete'
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
alias halt="sudo halt"
alias cpuinfo="lscpu"
alias meminfo="free -m -l -t"
alias psmem="ps auxf | sort -nr -k 4"
alias pscpu="ps auxf | sort -nr -k 3"
alias wget="wget -c"
alias top="htop"
alias mpd="ncmpcpp"
alias mpc="ncmpcpp"
alias now-playing="ncmpcpp --now-playing"
alias pacman="sudo pacman"
alias p="sudo pacman"
alias y="yaourt"
alias ctrl="systemctl"
alias mp="mplayer"
alias cower='cower --color=auto'
alias batt='sudo tlp-stat -b'
alias perl-rename='perl-rename -i'
alias prename='perl-rename -i'
alias encrypt='openssl enc -a -salt -aes-256-cbc'
alias decrypt='encrypt -d'
alias start='sudo systemctl start'
alias stop='sudo systemctl stop'
alias restart='sudo systemctl restart'
alias status='sudo systemctl status'
alias pa-speaker="pactl set-sink-port 0 analog-output-speaker"
alias pa-dock="pactl set-sink-port 0 analog-output"
alias pa-headphones="pactl set-sink-port 0 analog-output-headphones"
alias git=hub
alias update-repo='repo-add -n -d -s -f /home/auti/Dropbox/Public/ArchLinux/autermann.db.tar.gz  /home/auti/Dropbox/Public/ArchLinux/*.pkg.tar.xz'

alias -g S='>/dev/null 2>&1 &'

alias -s pdf="okular"

function okular  { command okular  $* >/dev/null 2>&1 &; }
function dolphin { command dolphin $* >/dev/null 2>&1 &; }
function kid3 { command kid3 $* >/dev/null 2>&1 &; }

function uml {
	cat $1 | plantuml -tsvg -p | inkscape --without-gui --export-pdf=/dev/stdout /dev/stdin 2>/dev/null >! $(basename $1 .txt).pdf
}

function dev() {
	sudo systemctl ${1:-start} \
		mongodb    \
		postgresql \
		tomcat6    \
		php-fpm    \
		nginx
}

function calc() {
	echo $(($*));
}

function to-alac() {
	for f in **/*.flac; do
		ffmpeg -i "$f" -n -acodec alac "${f%.flac}.m4a" && rm -f "$f"
	done
}

function to-flac {
	local f
	for f in **/*.m4a; do
		if ffmpeg -i "$f" 2>&1 | grep -q alac; then
			local n="${f%.m4a}"
			AtomicParsley "$f" -E \
				&& ffmpeg -i "$f" -acodec flac "${n}.flac" \
				&& metaflac --import-picture-from ${n}_artwork_1* \
				            --remove-tag MAJOR_BRAND \
				            --remove-tag MINOR_VERSION \
				            --remove-tag COMPATIBLE_BRANDS \
				            --remove-tag ENCODER \
				            "${n}.flac" \
				&& rm -f "$f" "${n}_artwork_"*
		fi
	done
}

function json-get() {
	curl -s "$1" | python -m json.tool
}

function format-xml() {
	T=$(tempfile)
	cat $1 > $T
	xmllint --format $T > $1
	rm -f $T
}

function itunes-playlist-to-dir {
	local PLYLST="$1"
	local SOURCE="$2" #/var/run/media/auti/Bay/Music
	local TARGET="$3" #/home/auti/Downloads/Music

	cat "${PLYLST}" \
		| iconv -f UTF-16LE -t UTF8 \
		| tail -n +2 \
		| cut  -s -f27 \
		| tr -d '\r' \
		| sed -e 's#M:\\##' -e 's#\\#\/#g' \
		| sort \
		| while read entry; do
			t_dir="${TARGET}/$(echo ${entry} | cut -d '/' -f 1-2)"
			mkdir -vp "${t_dir}"
			ln -vs "${SOURCE}/${entry}" "${t_dir}"
		done
}

cdpath=('.' '..' '~' '/media' /var/run/media/$USER)
zstyle ':completion:*:complete:(cd|pushd):*' tag-order \
	'local-directories named-directories path-directories'
zstyle ':completion:*' group-name ''


setopt localoptions nonomatch
