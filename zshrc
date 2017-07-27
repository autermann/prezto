source "/etc/zsh/prezto.zsh"
source "/etc/zsh/prezto/init.zsh"
source "/etc/zsh/alias.zsh"
source "/etc/zsh/opts.zsh"

zstyle ':completion:*:complete:(cd|pushd):*' tag-order \
        'local-directories named-directories path-directories'
zstyle ':completion:*' group-name ''

