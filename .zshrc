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
plugins=(git shrink-path)

source $ZSH/oh-my-zsh.sh

prompt_dir() {
  prompt_segment blue $CURRENT_FG "$(shrink_path -t)"
}

# OPAM configuration
. /home/jeannikl/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
