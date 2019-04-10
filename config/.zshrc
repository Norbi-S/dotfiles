source ~/antigen.zsh

# local binaries
export PATH=~/.local/bin/:$PATH

export LC_ALL="en_US.UTF-8"
export FZF_DEFAULT_COMMAND='rg --files --hidden'
(wal -r &)

ENABLE_CORRECTION="true"

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle command-not-found

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

# Load the theme.
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure

# Tell Antigen that you're done.
antigen apply

source ~/.aliases
