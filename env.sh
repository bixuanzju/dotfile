#!/bin/zsh

export MANPATH="/usr/local/man:/usr/man:/usr/local/share/man:/usr/share/man:/usr/local/pkg/perl/man:/usr/dt/man:/usr/openwin/man:/usr/sfw/man:/Users/jeremybi/local/man:/Users/jeremybi/local/share/man:/Users/jeremybi/.cabal/share/man:/usr/local/opt/coreutils/libexec/gnuman"

export PATH="/usr/local/share/npm/bin:/usr/X11R6/bin:bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/texbin"

alias ec='emacsclient -c -n'
alias ems='emacs --daemon'

export JAVA_HOME=$(/usr/libexec/java_home)

# Less

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
#
# Removed -S, don't want no-wrap by default (use less-nowrap for that)
# Added -x 4, to get 4-position as tab stop
export LESS='-F -g -i -M -R -w -X -x 4 -z-4'

# OPAM configuration
. /Users/jeremybi/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

export LC_ALL="en_US.UTF-8"


# Set the Less input preprocessor.
if (( $+commands[lesspipe.sh] )); then
    export LESSOPEN='| /usr/bin/env lesspipe.sh %s 2>&-'
fi

# Add GHC 7.10.2 to the PATH, via https://ghcformacosx.github.io/
export GHC_DOT_APP="/Applications/ghc-7.10.2.app"
if [ -d "$GHC_DOT_APP" ]; then
    export PATH="${HOME}/bin:${HOME}/.local/bin:${HOME}/.cabal/bin:${GHC_DOT_APP}/Contents/bin:${PATH}"
fi

if [ -e /Users/jeremybi/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/jeremybi/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

export NIX_PATH=nixpkgs=/Users/jeremybi/Projects/nixpkgs

alias rm='trash'
alias fuck='eval $(thefuck $(fc -ln -1 | tail -n 1)); fc -R'

export PATH="${HOME}/bin:${PATH}"

eval "$(stack --bash-completion-script "$(which stack)")"
