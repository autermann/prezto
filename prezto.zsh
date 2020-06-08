#
# Sets Prezto options.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

zstyle ':prezto:*:*' case-sensitive 'no'
zstyle ':prezto:*:*' color 'yes'
zstyle ':prezto:load' pmodule \
	'environment' \
	'terminal' \
	'editor' \
	'history' \
	'directory' \
	'spectrum' \
	'utility' \
	'completion' \
	'wakeonlan' \
	'pacman' \
	'rsync' \
	'utility' \
	'git' \
	'syntax-highlighting' \
	'history-substring-search' \
	'prompt' \
	'ruby' \
	'node'



zstyle ':prezto:module:editor' key-bindings 'vi'
zstyle ':prezto:module:editor' dot-expansion 'yes'
zstyle ':prezto:module:git:status:ignore' submodules 'all'
zstyle ':prezto:module:pacman' frontend 'yay'
zstyle ':prezto:module:prompt' theme 'agnoster'
zstyle ':prezto:module:syntax-highlighting' highlighters \
	'main' 'brackets' 'pattern' 'cursor'
zstyle ':prezto:module:terminal' auto-title 'yes'
