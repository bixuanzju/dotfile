#!/bin/zsh

export MANPATH="/usr/local/man:/usr/man:/usr/local/share/man:/usr/share/man:/usr/local/opt/coreutils/libexec/gnuman"

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/Library/TeX/texbin"

export JAVA_HOME=$(/usr/libexec/java_home)

alias ec='emacsclient -c -n'
alias ems='emacs --daemon'


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

# if [ -e /Users/jeremybi/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/jeremybi/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# export NIX_PATH=nixpkgs=/Users/jeremybi/Projects/nixpkgs

alias rm='trash'

export PATH="${HOME}/.local/bin:${PATH}"

# OPAM configuration
. /Users/jeremybi/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

eval "$(stack --bash-completion-script stack)"
