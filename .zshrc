# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="eastwood"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias rm="rm -i"
alias pg_ctl="pg_ctl -D /Users/jeremybi/postgres -l logfile"
alias emu="wine ~/Dropbox/git/compiler/junco/ASM_Emulator/ASMEmu.exe"
alias e="/usr/local/bin/emacsclient -c -n"
alias bzlg="bzr log -l"

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

# Customize to your needs...
export PATH=/usr/local/bin:/usr/texbin:/usr/local/Racket/bin:/usr/local/mysql/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin
export JAVA_HOME=`/usr/libexec/java_home -v 1.7`
export PATH="$HOME/Library/Haskell/bin:$HOME/scripts:$PATH"
export PATH="/usr/local/share/npm/bin:/Applications/MATLAB_R2013a.app/bin:/usr/local/opt/ruby/bin:/usr/local/share/python3:/usr/local/share/python:/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"


[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh
autoload -U compinit && compinit

if [ "$TERM" != "dumb" ]; then
    export LS_OPTIONS='--color=auto'
    eval `dircolors ~/.dir_colors`
fi

alias ls='ls $LS_OPTIONS -hF'
alias ll='ls $LS_OPTIONS -lhF'
function cdl { cd $US1; ls;}
alias desk='cd ~/Desktop'

export TERM=xterm-256color
