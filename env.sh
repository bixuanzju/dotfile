#!/bin/zsh

export MANPATH="/usr/local/man:/usr/man:/usr/local/share/man:/usr/share/man:/usr/local/pkg/perl/man:/usr/dt/man:/usr/openwin/man:/usr/sfw/man:/Users/jeremybi/local/man:/Users/jeremybi/local/share/man:/Users/jeremybi/.cabal/share/man:/usr/local/opt/coreutils/libexec/gnuman"

export PATH="/Users/jeremybi/Library/Haskell/bin:/Users/jeremybi/bin:/usr/local/share/npm/bin:/usr/X11R6/bin:/Users/jeremybi/.cask/bin:/Users/jeremybi/Applications/Racket v6.1/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/texbin"

alias ec='emacsclient -c -n'
alias ems='emacs --daemon'
alias bzl='bzr log -l'
alias hgg='hg log | less'

export JAVA_HOME=$(/usr/libexec/java_home)

# Less

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
#
# Removed -S, don't want no-wrap by default (use less-nowrap for that)
# Added -x 4, to get 4-position as tab stop
export LESS='-F -g -i -M -R -w -X -x 4 -z-4'

# Set the Less input preprocessor.
if (( $+commands[lesspipe.sh] )); then
    export LESSOPEN='| /usr/bin/env lesspipe.sh %s 2>&-'
fi
