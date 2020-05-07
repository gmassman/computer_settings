HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=$HISTSIZE
bindkey -v

export EDITOR=vim

source $HOME/.zsh.prompt
source $HOME/.zsh.aliases

# Load Git autocomplete
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)

# Load homebrew autocomplete
if type brew &>/dev/null; then
	FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

autoload -Uz compinit && compinit

export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
