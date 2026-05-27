fastfetch

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share/"
export PATH="$XDG_DATA_HOME/bin:$PATH"
export PATH="$HOME/Personal/dev:$PATH"


# Create zsh directories if they don't exist
[ -d "$XDG_CONFIG_HOME"/zsh ] || mkdir -p "$XDG_CONFIG_HOME"/zsh
[ -d "$XDG_CACHE_HOME"/zsh ] || mkdir -p "$XDG_CACHE_HOME"/zsh

# Customization
# HISTSIZE=1000000
# SAVEHIST=1000000
HISTFILE="$XDG_CACHE_HOME"/zsh/history
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory
setopt autocd beep extendedglob notify
bindkey -e
bindkey -s "^[1" "tmux-sessionizer^M"
bindkey -s "^[2" "source $HOME/.zshrc^M"

# Scripts
source $XDG_CONFIG_HOME/zsh/aliases
source $XDG_CONFIG_HOME/zsh/xdg_export
source $XDG_CONFIG_HOME/zsh/defaults

function cd () {
	builtin cd "$@" && ls
}

# Plugins
plug() {
  [ -d $XDG_CONFIG_HOME/zsh/plugins/"$1"/ ] \
  || git clone https://github.com/zsh-users/"$1".git \
  $XDG_CONFIG_HOME/zsh/plugins/"$1"
}

[ -d $XDG_CONFIG_HOME/zsh/plugins/ ] || mkdir -p $XDG_CONFIG_HOME/zsh/plugins/

plug "zsh-syntax-highlighting"
plug "zsh-completions"
plug "zsh-autosuggestions"


source $XDG_CONFIG_HOME/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $XDG_CONFIG_HOME/zsh/plugins/zsh-completions/zsh-completions.plugin.zsh
source $XDG_CONFIG_HOME/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

fpath=($XDG_CONFIG_HOME/zsh/plugins/zsh-autosuggestions/src $fpath)
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
