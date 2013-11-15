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
alias y="sudo pacman"
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


function calc() {
	echo $(($*));
}

function to-alac() {
	for f in **/*.flac; do
		ffmpeg -i "$f" -vn -acodec alac "${f%.flac}.m4a" && rm -f "$f"
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

function delete(){
  local f=$1          
  rm `readlink ${f}`
  rm ${f}
  touch ${f};
}

function relink() {
	for d in {/home/auti,/media/{Hubert,Ogden,Fridolin}}/Movies; do
		if [[ -d ${d} ]]; then ln -sf ${d}/* /home/auti/media/Movies; fi
	done
}

cdpath=('.' '..' '~' '/media' /var/run/media/$USER)
zstyle ':completion:*:complete:(cd|pushd):*' tag-order \
	'local-directories named-directories path-directories'
zstyle ':completion:*' group-name ''

setopt localoptions nonomatch
