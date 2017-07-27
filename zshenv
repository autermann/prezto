#
# Defines environment variables.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

#
# Browser
#
export BROWSER='google-chrome'
export EDITOR='vim'
export VISUAL="$EDITOR"
export PAGER='less'

[[ -z "$LANG" ]] && export LANG='en_US.UTF-8'

typeset -gU cdpath fpath mailpath path

# Set the list of directories that Zsh searches for programs.
path=(/usr/local/{bin,sbin} $path)

cdpath=('.'  '~' "/var/run/media/$USER")

export LESS='-g -i -M -R -w -z-4'

if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

if [[ ! -d "$TMPDIR" ]]; then
  export TMPDIR="$(mktemp -d)"
fi

TMPPREFIX="${TMPDIR%/}/zsh"

DEFAULT_USER=autermann

export GOPATH="${HOME}/Source/go"
