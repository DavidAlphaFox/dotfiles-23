# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# Path to your oh-my-zsh installation.
export ZSH="/home/crag/.oh-my-zsh"
autoload -U compinit
compinit

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#  ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

plugins=(
  zsh-vi-mode
  zoxide
  copybuffer
  copydir
  copyfile
  ripgrep
  genpass
  python
  history
  colored-man-pages
  extract
  sudo
  command-not-found
  node
  dircycle
  docker
  docker-compose
  dotnet
  systemd
  ripgrep
  ag
  fd
  fzf
  fzf-tab
)

# -< Source files or scripts >-
source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

zvm_after_init_commands+=('enable-fzf-tab')

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

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


# -> Config <-
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
#zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd $realpath'
zstyle ':fzf-tab:complete:*:*' fzf-preview '([[ -f $realpath ]] && (bat --style=numbers --color=always $realpath || cat $realpath)) || ([[ -d $realpath ]] && (tree -C $realpath | less)) || echo $realpath 2> /dev/null | head -200'

# -< Aliases >-
# HACK: Config alias
alias starshipc="vim ~/.config/starship.toml"
alias alacric="vim ~/.config/alacritty/alacritty.yml"
alias swayc="vim ~/.config/sway/config"
alias newmc="vim ~/.config/newm/config.py"
# alias i3c="vim ~/.config/i3/config"
# alias i3barc="~/.config/i3status/config"
alias zshc="vim ~/.zshrc"
alias tmuxc="vim ~/.tmux.conf"
alias firefoxc="vim ~/.mozilla/firefox/profiles.ini"
alias kittyc="vim ~/.config/kitty/kitty.conf"
alias dnsc="vim /etc/resolv.conf"
alias nftc="vim /etc/nftables.conf"
alias grubc="sudoedit /etc/default/grub"
# HACK: Config Nvim Aliases
alias vimc='vim ~/.config/nvim/init.lua'
alias vimp='vim ~/.config/nvim/lua/plugins/manage.lua'
alias vimm='vim ~/.config/nvim/lua/keymappings.lua'
alias vims='vim ~/.config/nvim/lua/settings.lua'
alias vimt='vim ~/.config/nvim/lua/colorscheme.lua'
alias vimf='vim ~/.config/nvim/lua/config/snippets'
alias viml='vim ~/.config/nvim/lua/status_line/init.lua'
alias vimls='vim ~/.config/nvim/lua/lsp_config/supports.lua'
alias vimcp='vim ~/.config/nvim/lua/plugins'
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
# HACK: Command alternatives
alias ping="prettyping"
alias icat="kitty +kitten icat"
alias js="/usr/bin/node ~/.noderc"
alias ls="logo-ls"
alias cp="rsync -P"
alias tree="ls -R"
alias vi="nvim"
alias vim="nvim"
# HACK: HACK: fzf alias
alias fpaci="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias fpacr="pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"
alias fyay="yay -Slq | fzf --multi --preview 'yay -Si {1}' | xargs -ro yay -S"
# HACK: short alias
# alias aid="swaymsg -t get_tree | grep "app_id""
alias zt="zathura"
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias music="termusic"
# -< Environ variable >-
export ANDROID_HOME=/opt/android-sdk
export MYSQL_PS1="\n \d  ﯐ "
export LC_ALL=es_MX.UTF-8
export LANG=es_MX.UTF-8
export LANGUAGE=es_MX.UTF-8
export TERM="xterm-kitty"
export VISUAL=nvim
export EDITOR=$VISUAL
export PYTHONSTARTUP=~/.pyrc
export BAT_THEME="gruvbox-dark"
export FZF_DEFAULT_OPTS="--height 40% --reverse --bind='?:toggle-preview' --pointer='»'"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/wxgtk-dev/lib/
export PATH="$HOME/.poetry/bin:$PATH"
export MESA_LOADER_DRIVER_OVERRIDE=iris
source ~/.passmaria.zsh

# -< Evals >-
eval "$(starship init zsh)"


# BEGIN_KITTY_SHELL_INTEGRATION
if test -e "/usr/lib/kitty/shell-integration/kitty.zsh"; then source "/usr/lib/kitty/shell-integration/kitty.zsh"; fi
# END_KITTY_SHELL_INTEGRATION
