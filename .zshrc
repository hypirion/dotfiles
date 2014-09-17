ZSH=$HOME/.oh-my-zsh
ZSH_THEME="agnoster"
DISABLE_CORRECTION="true"

go_err_nils() {
    echo 5 k \
         $(find . -name '*.go' -exec grep 'if err != nil' {} \; | wc -l) \
         $(find . -name '*.go' -exec cat {} \; | wc -l) \
         / 100 '*' p | dc
}

# Aliases
alias emacs="emacs -nw"
alias update="sudo apt-get update"
alias upgrade="sudo apt-get upgrade"
alias install="sudo apt-get install"
alias optipng-max="optipng -f0-5 -zc6-9 -i0 -zm6-9"
alias goerrnils='echo $(go_err_nils)'

# Remove the beeps
setopt NO_BEEP

# Da plugins
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Want gdc to point to the d compiler, not `git diff --cached`.
unalias gdc

# OPAM configuration
. /home/jeannikl/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

PATH="$PATH:~/.cabal/bin:/opt/cabal/1.20/bin:/opt/ghc/7.8.3/bin:/opt/happy/1.19.4/bin:/opt/alex/3.1.3/bin"
