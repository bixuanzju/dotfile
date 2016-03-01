#!/bin/zsh

export MANPATH="/usr/local/man:/usr/man:/usr/local/share/man:/usr/share/man:/usr/local/opt/coreutils/libexec/gnuman"

export PATH="/usr/local/bin:/usr/X11R6/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/Library/TeX/texbin"

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

# if [ -e /Users/jeremybi/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/jeremybi/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# export NIX_PATH=nixpkgs=/Users/jeremybi/Projects/nixpkgs

alias rm='trash'
alias fuck='eval $(thefuck $(fc -ln -1 | tail -n 1)); fc -R'

export PATH="${HOME}/.local/bin:${PATH}"

eval "$(stack --bash-completion-script stack)"

source <(f2j --bash-completion-script `which f2j`)

alias emc="/usr/local/Cellar/emacs-mac/emacs-24.5-z-mac-5.13/Emacs.app/Contents/MacOS/Emacs &"
