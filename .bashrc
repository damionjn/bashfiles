# Prompt
[[ -f "$HOME/.bash_prompt" ]] && source "$HOME/.bash_prompt"

# Larger bash history (default is 500)
export HISTFILESIZE=10000
export HISTSIZE=10000

PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# Load things
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# Locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Misc settings
export EDITOR=vim
export NODE_ENV=production
