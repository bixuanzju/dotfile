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
plugins=(autojump cp brew git github osx)

source $ZSH/oh-my-zsh.sh

# Aliases
alias rm="rm -i"
alias pg_ctl="pg_ctl -D /Users/jeremybi/postgres -l logfile"
# alias emu="wine ~/Dropbox/git/compiler/junco/ASM_Emulator/ASMEmu.exe"
alias ec="/usr/local/bin/emacsclient -c -n"
alias bzlg="bzr log -l"
alias vi=vim
# tmux
alias tnew="tmux new -s"
alias tma="tmux attach"
alias tml="tmux list-window"
# alias ktcm="kill `lsof -i TCP:8080 | awk '/LISTEN/{print $2}'`"

# Colorize terminal
# if [ "$TERM" != "dumb" ]; then
#     export LS_OPTIONS='--color=auto'
#     eval `dircolors ~/.dir_colors`
# fi

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

# Sets reasonable OS X defaults.

# Disable press-and-hold for keys in favor of key repeat.
defaults write -g ApplePressAndHoldEnabled -bool false

# Always open everything in Finder's list view. This is important.
defaults write com.apple.Finder FXPreferredViewStyle Nlsv

# Show the ~/Library folder.
chflags nohidden ~/Library

# Run the screensaver if we're in the bottom-left hot corner.
defaults write com.apple.dock wvous-bl-corner -int 5
defaults write com.apple.dock wvous-bl-modifier -int 0

# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`
if $(gls &>/dev/null)
then
  alias ls="gls -F --color"
  alias l="gls -lAh --color"
  alias ll="gls -l --color"
  alias la='gls -A --color'
fi
