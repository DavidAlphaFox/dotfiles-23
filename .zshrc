# zmodload zsh/zprof
# Start configuration added by Zim install {{{
#
# User configuration sourced by interactive shells
#

# -----------------
# Zsh configuration
# -----------------

#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -e

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
# SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# -----------------
# Zim configuration
# -----------------

# Use degit instead of git as the default tool to install and update modules.
#zstyle ':zim:zmodule' use 'degit'

# --------------------
# Module configuration
# --------------------

#
# git
#

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
# zstyle ':zim:git' aliases-prefix 'g'

#
# input
#

# Append `../` to your input for each `.` you type after an initial `..`
zstyle ':zim:input' double-dot-expand yes

#
# zsh-autosuggestions
#

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
# ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# ------------------
# Initialize modules
# ------------------

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh
source ~/.zshfunc

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# zsh-history-substring-search
#

zmodload -F zsh/terminfo +p:terminfo
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key

#zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd $realpath'
zstyle ':fzf-tab:complete:*:*' fzf-preview '~/.scripts/preview $realpath'

# zstyle :prompt:pure:execution_time      color
# zstyle :prompt:pure:git:arrow           color
# zstyle :prompt:pure:git:branch          color '#a6e3a1'
# zstyle :prompt:pure:git:dirty           color '#f5c2e7'
# zstyle :prompt:pure:git:action          color '#f38ba8'
# zstyle :prompt:pure:git:stash           color '#f9e2af'
# zstyle :prompt:pure:path                color '#89b4fa'
# zstyle :prompt:pure:prompt:success      color '#94e2d5'
# zstyle :prompt:pure:user                color
# zstyle :prompt:pure:user:root           color
# zstyle :prompt:pure:virtualenv          color '#edabd2'

# PROMPT='%(?.%F{#fb5c8e}ﰉ %F{#f47d49}ﰉ %F{#a29dff}ﰉ.%F{#a29dff}ﰉ %F{#f47d49}ﰉ %F{#fb5c8e}ﰉ)%f '
PS1='
%(!.%B%F{red}%n%f%b in .${SSH_TTY:+"%B%F{yellow}%n%f%b in "})${SSH_TTY:+"%B%F{green}%m%f%b in "}%B%F{cyan}%~%f%b${(e)git_info[prompt]}${VIRTUAL_ENV:+" via %B%F{yellow}${VIRTUAL_ENV:t}%b%f"}${duration_info}
%B%(1j.%F{blue}*%f .)%(?.%F{#f38ba8}ﰉ %F{#f9e2af}ﰉ %F{#a6e3a1}ﰉ.%F{#a6e3a1}ﰉ %F{#f9e2af}ﰉ %F{#f38ba8}ﰉ)%f%b '

# -< Evals >-
eval "$(zoxide init zsh)"

# -< Aliases >-
# HACK: Command alternatives
# alias ...="cd ../.."
alias ping="prettyping"
alias icat="kitty +kitten icat"
alias js="/usr/bin/node ~/.noderc"
alias ls="logo-ls"
alias la="logo-ls -A"
alias cp="rsync -P"
alias tree="ls -R"
alias vi="nvim"
alias vim="nvim"
alias zt="zathura"
alias music="XDG_CACHE_HOME=/home/$USER/.cache termusic"
alias recorder="wf-recorder -f recording-$(date +%s).mp4 -c libx264rgb -d /dev/dri/renderD129 -x yuv444p"
# alias aid="swaymsg -t get_tree | grep "app_id""
alias help="cht.sh"
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
# HACK: docker Nftables
alias don='sudo nft -f /etc/nftables-docker.conf && sudo systemctl start docker'
alias doff='sudo systemctl stop docker.service docker.socket && sudo nft -f /etc/nftables.conf && sudo ip l d docker0'
alias dor='doff && don'
# HACK: Config alias
alias grubc="sudoedit /etc/default/grub"
alias alacric="nvim ~/.config/alacritty/alacritty.yml"
alias swayc="nvim ~/.config/sway/config"
alias newmc="nvim ~/.config/newm/config.py"
alias zshc="nvim ~/.zshrc"
alias zshf="nvim ~/.zshfunc"
alias zimc="nvim ~/.zimrc"
alias tmuxc="nvim ~/.tmux.conf"
alias firefoxc="nvim ~/.mozilla/firefox/profiles.ini"
alias kittyc="nvim ~/.config/kitty/kitty.conf"
alias dnsc="nvim /etc/resolv.conf"
alias nftc="nvim /etc/nftables.conf"
alias starshipc="nvim ~/.config/starship.toml"
# HACK: Config Nvim Aliases
alias vimc='nvim ~/.config/nvim/init.lua'
alias vimp='nvim ~/.config/nvim/lua/plugins.lua'
alias vimk='nvim ~/.config/nvim/after/plugin/keymappings.lua'
alias vimd='nvim ~/.config/nvim/after/plugin/defaults.lua'
alias vimt='nvim ~/.config/nvim/lua/colorscheme.lua'
alias viml='nvim ~/.config/nvim/lua/config/lsp/init.lua'
# HACK: Jump alias
alias Applications="cd /usr/share/applications"
alias Desktop="cd /$HOME/Escritorio"
alias Download="cd /$HOME/Descargas"
alias Document="cd /$HOME/Documentos"
alias Images="cd /$HOME/Imágenes"
alias Music="cd /$HOME/Música"
alias Videos="cd /$HOME/Vídeos"
alias Git="cd /$HOME/Git"
alias Usb="cd /run/media/crag"
# HACK: fzf alias
alias paci="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias pacr="pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"
alias ys="yay -Slq | fzf --multi --preview 'yay -Si {1}' | xargs -ro yay -S"
alias ci="{ find . -xdev -printf '%h\n' | sort | uniq -c | sort -k 1 -n; } 2>/dev/null"
alias gbc="git switch -c"

# -< Environ variable >-
export MYSQL_PS1="\n \d  ﯐ "
export TERM="xterm-kitty"
export VISUAL=nvim
export EDITOR=$VISUAL
export PYTHONSTARTUP=~/.pyrc
export BAT_THEME="Catppuccin-mocha"

# source ~/.passmaria.zsh

# BEGIN_KITTY_SHELL_INTEGRATION
if test -e "/usr/lib/kitty/shell-integration/zsh/kitty.zsh"; then
  source "/usr/lib/kitty/shell-integration/zsh/kitty.zsh";
fi
[ ! -f /tmp/crag/.cache/bat/themes.bin ] && bat cache --build > /dev/null
# END_KITTY_SHELL_INTEGRATION
# eval "$(starship init zsh)"
# zprof
