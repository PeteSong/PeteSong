####################
# +++++ My Environment +++++
####################

### Get the running shell
if test -n "$ZSH_VERSION"; then
  PROFILE_SHELL=zsh
elif test -n "$BASH_VERSION"; then
  PROFILE_SHELL=bash
elif test -n "$KSH_VERSION"; then
  PROFILE_SHELL=ksh
elif test -n "$FCEDIT"; then
  PROFILE_SHELL=ksh
elif test -n "$PS3"; then
  PROFILE_SHELL=unknown
else
  PROFILE_SHELL=sh
fi

export LANG=en_US.UTF-8


####################
# functions
####################
enable-sudo-touchid() {
  sudo sed -i -e '1s;^;auth       sufficient     pam_tid.so\n;' /etc/pam.d/sudo
}

# Remove .DS_Store files recursively in a directory, default .
rm_dsstore() {
  find "${@:-.}" -type f -name .DS_Store -delete
}

# Date string to timestamp
s_t() {
  # date -d "2019-08-31T16:35:00 UTC" +%s
  date -d "$@ UTC" +%s
}

# Timestamp to date string
t_s() {
  #date -d "@1575288600" -u +"%Y-%m-%dT%H:%M:%S UTC"
  date -d "@$@" -u +"%Y-%m-%dT%H:%M:%S UTC"
}


preview-file() {
  if [[ -f "$1" ]]; then
    if [ $(head -c 4 "$1") = "%PDF" ]; then
      qlmanage -p "$1" > /dev/null 2>&1
    else
      cat "$1"
    fi
  elif [[ -d "$1" ]]; then
    tree -C "$1" | less
  else
    echo "$1" 2> /dev/null | head -200
  fi
}

####################
# Home brew
####################
eval "$(/opt/homebrew/bin/brew shellenv)"

## coreutils
PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"

#alias brews='brew list --formula --version && echo && echo ---cask--- && brew list --cask --version && echo && echo ---pinned--- && brew list --pinned --version && echo && echo ---outdated--- && brew outdated && echo'
alias brews='echo -- User installed -- && brew leaves && brew list --cask --version && echo -- Outdated -- && brew outdated'
alias brewsp='brew list --pinned'

alias bubo='brew update && brew outdated'
alias bubc='brew upgrade && brew cleanup'
alias bubu='bubo && bubc'

alias brewdeps='brew deps --tree'
alias brewuses='brew uses --recursive --install'

# macfuse: https://osxfuse.github.io
# ntfs-3g-mac: extention of macfuse for NTFS  https://github.com/osxfuse/osxfuse/wiki/NTFS-3G
# follow the instructions above to install andsetup
# use `diskutil list` to get the NTFS disk identifier
ntfs_disk=/dev/disk4s1
alias ntfs='sudo diskutil unmount ${ntfs_disk} && sudo /opt/homebrew/sbin/mount_ntfs ${ntfs_disk} /Volumes/NTFS'


####################
# MacPorts
####################
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

alias ports='echo -- User installed -- && port installed requested && echo -- Outdated -- && port outdated'
alias portdeps='port rdeps'
alias portuses='port rdependents'


####################
# ~/.local/bin
####################
export PATH=$HOME/.local/bin:$PATH


####################
# SDKMAN! Java
####################
source "$HOME/.sdkman/bin/sdkman-init.sh"


####################
# Android
####################
export ANDROID_HOME=/Users/pete/Library/Android/sdk
export PATH=$ANDROID_HOME/platform-tools:$PATH


####################
# Rust cargo
####################
source  "$HOME/.cargo/env"


####################
# anaconda - python
####################
anaconda() {
  # >>> conda initialize >>>
  # !! Contents within this block are managed by 'conda init' !!
  __conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
  if [ $? -eq 0 ]; then
    eval "$__conda_setup"
  else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
      . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
      export PATH="/opt/anaconda3/bin:$PATH"
    fi
  fi
  unset __conda_setup
  # <<< conda initialize <<<
}

miniconda() {
  # >>> conda initialize >>>
  # !! Contents within this block are managed by 'conda init' !!
  __conda_setup="$('/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
          . "/opt/miniconda3/etc/profile.d/conda.sh"
      else
          export PATH="/opt/miniconda3/bin:$PATH"
      fi
  fi
  unset __conda_setup
  # <<< conda initialize <<<
}


####################
# python
####################
# set path of PYENV
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

alias pipi='pip install -U'
alias uvp='uv pip'


####################
# node.js
####################
alias npg='npm -g'

alias ni='npm install'
alias nr='npm run'
alias nl="npm list --dept=0"
alias nlg="npm list -g --dept=0"


####################
# ruby
####################
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh


####################
# common alias
####################
alias path='sed "s/:/\n/g" <<< "$PATH"'

#alias gls='ls -Fh --show-control-chars --color=auto'
# alias ls='exa -h -F --icons -s modified'
alias ls='gls -Fht --show-control-chars --color=auto'
alias l='ls'
alias ll='ls -l'
alias la='ls -la'
alias l1='ls -1'
alias lr='ls -r'
alias lt='ls -tr'
alias l.='ls -ld .*'

#alias less='slit'
alias less='less --ignore-case'

alias dud='du -d 1 -h | sort -h'
alias duf='du -sh *'
alias df='df -h'

alias sortnr='sort -n -r'
alias whereami=display_info

alias md='mkdir -p'
alias rd=rmdir

alias grep='grep --color=auto'
alias sgrep='grep -n -H -C 5 --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

alias cls='clear'

alias lsps="ps aux G"
alias pst="pstree -g 2"

alias ofd='open $PWD'
alias showfiles='defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder'
alias hidefiles='defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder'

#copy output of last command to clipboard
alias cl="fc -e - | pbcopy"

# top
alias cpu='top -o cpu'
alias mem='top -o rsize' # memory

alias pwd='echo $PWD|pbcopy && /bin/pwd'


# copy the working directory path
alias cpwd='/bin/pwd|tr -d "\n" | pbcopy'

### zsh alias ###
if [ "$PROFILE_SHELL" = "zsh" ]; then
  # Command line head / tail shortcuts
  alias -g H='| head'
  alias -g T='| tail'
  alias -g G='| grep --color=auto -i'
  alias -g L="| less"

  alias -g X="| xargs"
  alias -g O="| xargs open"
  alias -g F="| fzf"
  alias -g LL="2>&1 | less"
  alias -g CA="2>&1 | cat -A"
  alias -g NE="2> /dev/null"
  alias -g NUL="> /dev/null 2>&1"
fi


####################
# ripgrep
####################
alias rg='rg --ignore-file ~/.gitignore'


####################
# fzf
####################
export FZF_DEFAULT_COMMAND="fd --hidden --exclude .git --color=auto . $1"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d -d 4 -L"
export FZF_CTRL_R_OPTS="
    --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
    --color header:italic
    --header 'Press CTRL-Y to copy command into clipboard'
"
export FZF_DEFAULT_OPTS="
    --height 45%
    --layout=reverse
    --preview '(([[ -f {} ]] && (cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200)'
    --preview-window hidden
    --bind 'f1:execute(less -f {})'
    --bind 'ctrl-o:execute(open {})'
    --bind 'ctrl-/:change-preview-window(right,70%|down,50%,border-horizontal|hidden|right)'
"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

alias z='cd $(fd --type d . -d 4 -L  / | fzf)'


####################
# iterm
####################
if [[ $TERM_PROGRAM == "iTerm.app" ]]; then
    test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
fi


####################
# JetBrains
####################
# Added by Toolbox App
export PATH="$PATH:/Users/pete/Library/Application Support/JetBrains/Toolbox/scripts"


####################
# WezTerm
####################
export PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS"

