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
zstyle ':fzf-tab:complete:*:*' fzf-preview '([[ -f $realpath ]] && (bat --style=numbers --color=always $realpath || cat $realpath)) || ([[ -d $realpath ]] && (tree -C $realpath | less)) || echo $realpath 2> /dev/null | head -200'

# zstyle :prompt:pure:execution_time      color
# zstyle :prompt:pure:git:arrow           color
zstyle :prompt:pure:git:branch          color '#84c49b'
zstyle :prompt:pure:git:dirty           color '#f79f79'
zstyle :prompt:pure:git:action          color '#e68ac1'
zstyle :prompt:pure:git:stash           color '#f6e08b'
zstyle :prompt:pure:path                color '#aed9f6'
zstyle :prompt:pure:prompt:success      color '#b2aeff'
# zstyle :prompt:pure:user                color
# zstyle :prompt:pure:user:root           color
zstyle :prompt:pure:virtualenv          color '#edabd2'

PROMPT='%(?.%F{#fb5c8e}ﰉ %F{#f47d49}ﰉ %F{#a29dff}ﰉ.%F{#a29dff}ﰉ %F{#f47d49}ﰉ %F{#fb5c8e}ﰉ)%f '

# -< Evals >-
eval "$(zoxide init zsh)"

# Function
sr(){
  rg "$1" -l | xargs sed -i "s/$1/$2/g"
}

# Util funtions
encrypt(){
  openssl enc -aes-256-cbc -md sha512 -pbkdf2 -iter 100000 -salt -in $1 -out $2
}

decrypt(){
  openssl enc -d -aes-256-cbc -md sha512 -pbkdf2 -iter 100000 -salt -in $1 -out $2
}

acp() {
  git add .
  git commit -m "$1"
  git push
}

dhg() {
  git checkout --orphan latest_branch
  git add -A
  git commit -am "$1"
  git branch -D master
  git branch -m master
  git push -f origin master
}

fapp() {
	selected="$(/bin/ls /usr/share/applications | fzf -e)"
	nohup `grep '^Exec' "/usr/share/applications/$selected" | tail -1 | sed 's/^Exec=//' | sed 's/%.//'` >/dev/null 2>&1&
}

fkill() {
  local pid

  pid="$(
    pgrep . -l \
      | fzf -m \
      | awk '{print $1}'
  )" || return
  if [ $pid ];then
    kill -"${1:-9}" "$pid"
  fi
}

fktmux() {
    local sessions
    sessions="$(tmux ls|fzf --exit-0 --multi)"  || return $?
    local i
    for i in "${(f@)sessions}"
    do
        [[ $i =~ '([^:]*):.*' ]] && {
            echo "Killing $match[1]"
            tmux kill-session -t "$match[1]"
        }
    done
}

gitignore() {
    if [ $# = 1 ]; then
      curl -L -s https://www.gitignore.io/api/$@ > .gitignore
    else
      echo 'usage: gitignore django'
    fi
}

vims(){
	nvim -p $(rg $1 -l | xargs)
}

lazy_load() {
    echo "Lazy loading $1 ..."
    local -a names
    if [[ -n "$ZSH_VERSION" ]]; then
        names=("${(@s: :)${1}}")
    else
        names=($1)
    fi
    unalias "${names[@]}"
    . $2
    shift 2
    $*
}

group_lazy_load() {
    local script
    script=$1
    shift 1
    for cmd in "$@"; do
        alias $cmd="lazy_load \"$*\" $script $cmd"
    done
}
group_lazy_load node npm yarn
unset -f group_lazy_load

# -< Aliases >-
# HACK: Command alternatives
# alias ...="cd ../.."
alias ping="prettyping"
alias icat="kitty +kitten icat"
alias js="/usr/bin/node ~/.noderc"
alias ls="logo-ls"
alias cp="rsync -P"
alias tree="ls -R"
alias vi="nvim"
alias vim="nvim"
alias zt="zathura"
alias music="termusic"
alias aid="swaymsg -t get_tree | grep "app_id""
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
alias fpaci="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias fpacr="pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"
alias fyay="yay -Slq | fzf --multi --preview 'yay -Si {1}' | xargs -ro yay -S"
# HACK: Tem alias
alias wpstart="docker start wordpressdb wordpress"
alias wpstop="docker stop wordpress wordpressdb"

# -< Environ variable >-
export MYSQL_PS1="\n \d  ﯐ "
export TERM="xterm-kitty"
export VISUAL=nvim
export EDITOR=$VISUAL
export PYTHONSTARTUP=~/.pyrc
export BAT_THEME="gruvbox-dark"
export FZF_DEFAULT_OPTS="--prompt='ﰉ ' --pointer='ﰊ' --height 40% --reverse --bind='?:toggle-preview'"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
# source ~/.passmaria.zsh

# BEGIN_KITTY_SHELL_INTEGRATION
if test -e "/usr/lib/kitty/shell-integration/zsh/kitty.zsh"; then
  source "/usr/lib/kitty/shell-integration/zsh/kitty.zsh";
fi
# END_KITTY_SHELL_INTEGRATION
# eval "$(starship init zsh)"
# zprof
