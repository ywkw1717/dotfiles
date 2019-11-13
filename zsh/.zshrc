########################################
# prompt configuration
PROMPT='%{${fg[yellow]}%}%~%{${reset_color}%}:%n@${vcs_info_msg_0_}%(?.%B%F{green}.%B%F{blue})%(?!(*｡˃̵ω ˂̵｡) < !(๑˃̵ᴗ˂̵%)ﻭ < )%f%b'

# Prompt designation of "Is it by any chance this command?"
SPROMPT="%{$fg[yellow]%}%{$suggest%}(*'~'%)? < もしかして %B%r%b %{$fg[yellow]%}かな? [そう!(y), 違う!(n),a,e]:${reset_color} "

plugins=(git)

########################################
# Complement

# By complement, I match even a small letter with a capital letter
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# I take off the directory which there is from a complement candidate now
zstyle ':completion:*' ignore-parents parent pwd ..

# Complement the command name after sudo
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# Supplement process name of ps command
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

########################################
# vcs_info

# This line is configuration that display the current path. Don't related the configuration that show the branch and coloring
RPROMPT="%{${fg[blue]}%}[%~]%{${reset_color}%}"

autoload -Uz vcs_info
setopt prompt_subst
autoload -Uz add-zsh-hook
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
function _update_vcs_info_msg() {
    LANG=en_US.UTF-8 vcs_info
    RPROMPT="${vcs_info_msg_0_}"
}
add-zsh-hook precmd _update_vcs_info_msg

########################################
# Option

# can be displayed Japanese filename
setopt print_eight_bit

# disable beep
setopt no_beep

# disable flow control
setopt no_flow_control

# don't finish zsh, Ctrl-D
setopt ignore_eof

# deal with comment after word that is '#'
setopt interactive_comments

# cd only directory name
setopt auto_cd

# dont't store the same command in history
setopt hist_ignore_all_dups

# don't store the command that start the space, in history
setopt hist_ignore_space

# use wildcard extended
setopt extended_glob

# if mistake command, show like command
setopt correct

# about auto-complete
setopt list_packed

# Use the regular expression that is compatible with PCRE
setopt re_match_pcre

########################################
# Keybind

# emacs like keybind
bindkey -e

# solution of ctrl arrow problem
bindkey ';5D' emacs-backward-word
bindkey ';5C' emacs-forward-word

########################################
# alias

# LS_COLORS use --color option?
alias ls='ls --color=always'
alias la='ls -ah'
alias ll='ls -lh'
alias l='ls -lht|head'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias open='gnome-open'

# gdb, Do not print the introductory and copyright messages.
alias gdb='gdb -q'

# copy output in clipboard
alias pbcopy='xsel --clipboard --input'

# execute ls after cd
alias cd='cd'
function cd() {
  builtin cd $1 && l
}

########################################
# Other

# history configuration
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# auto-complete
autoload -U compinit
compinit

# can use color
autoload -Uz colors
colors

autoload -Uz select-word-style
select-word-style default

zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

# environment(including PATH)
source /etc/environment

# You may need to manually set your language environment
export LANG=en_US.UTF-8

if [ -d $HOME/ctf/tool/bin ]; then
  export PATH=$PATH:$HOME/ctf/tool/bin
fi

# Android Environment
export ANDROID_HOME=$HOME/android-sdk-linux
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_NDK_HOME
export ANDROID_NDK_ROOT=/usr/local/android-ndk-r10d

# LS_COLORS
eval $(dircolors $HOME/.zsh/color/dircolors.ansi-universal)

# go
if [ -d $HOME/.go ]; then
  export GOPATH=$HOME/.go
fi

if [ -d $HOME/.go/bin ]; then
  export PATH=$PATH:$HOME/.go/bin
fi

export PATH=$PATH:/usr/lib/go-1.10/bin/go

if [ -d $HOME/.local/bin ]; then
  export PATH=$PATH:$HOME/.local/bin
fi

########################################
# Library

load_if_exists () {
  if [ -e $1 ]; then
    source $1
  fi
}

# nvm
# very slow
load_if_exists "$HOME/.nvm/nvm.sh"
export NVM_DIR="$HOME/.nvm"

#rbenv
if [ -d $HOME/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# Virtualenvwrapper
# slow
if [ -f /usr/share/virtualenvwrapper/virtualenvwrapper.sh ]; then
  export WORKON_HOME=$HOME/.virtualenvs
  source /usr/share/virtualenvwrapper/virtualenvwrapper.sh
fi

#coffee
if [ -d $HOME/node_modules/coffee-script/bin ]; then
  export PATH="$HOME/node_modules/coffee-script/bin:$PATH"
fi
########################################
# zplug
source ~/.zplug/init.zsh

# (1) plugin description
zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-completions'
# zplug 'b4b4r07/enhancd', use:init.sh
zplug 'zsh-users/zsh-syntax-highlighting', defer:0
# zplug "yous/lime"

# # (2) install
if ! zplug check --verbose; then
  printf 'Install? [y/N]: '
  if read -q; then
    echo; zplug install
  fi
fi

zplug load --verbose

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# tmux
[[ -z "$TMUX" && ! -z "$PS1" ]] && exec tmux
