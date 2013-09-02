# Initialize completion
autoload -U compinit
compinit

# Add path
export PATH=/usr/local/bin:/usr/texbin:/Applications/Racket/bin:/usr/local/sbin:${PATH}
export PATH=/usr/local/share/npm/bin:/Applications/MATLAB_R2013a.app/bin:$HOME/Library/Haskell/bin:$HOME/scripts:${PATH}
# export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
# export JAVA_HOME=`/usr/libexec/java_home -v 1.7`

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(autojump cp brew svn git github osx)

source $ZSH/oh-my-zsh.sh

# Aliases
alias rm="rm -i"
alias pg_ctl="pg_ctl -D /Users/jeremybi/postgres -l logfile"
# alias emu="wine ~/Dropbox/git/compiler/junco/ASM_Emulator/ASMEmu.exe"
alias e="/usr/local/bin/emacsclient -c -n"
alias ec="/usr/local/bin/emacsclient -t"
alias bzlg="bzr log -l"
alias tnew="tmux new -s"
alias vi=vim
# alias ktcm="kill `lsof -i TCP:8080 | awk '/LISTEN/{print $2}'`"

# Colorize terminal
# if [ "$TERM" != "dumb" ]; then
#     export LS_OPTIONS='--color=auto'
#     eval `dircolors ~/.dir_colors`
# fi

# alias ls='ls $LS_OPTIONS -hF'
# alias ll='ls $LS_OPTIONS -lhF'

# Nicer history
export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

# Use vim as the editor
export EDITOR=vim

# Set architecture flags
export ARCHFLAGS="-arch x86_64"

export DEFAULT_USER="jeremybi"

# pip should only run if there is a virtualenv currently activated
# export PIP_REQUIRE_VIRTUALENV=true
# cache pip-installed packages to avoid re-downloading
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache

export CVSROOT=/Users/jeremybi/cvsroot

alias desk='cd ~/Desktop'

# By default, zsh considers many characters part of a word (e.g., _ and -).
# Narrow that down to allow easier skipping through words via M-f and M-b.
export WORDCHARS='*?[]~&;!$%^<>'

source /usr/local/bin/virtualenvwrapper.sh

# . /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
