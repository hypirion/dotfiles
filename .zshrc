ZSH=$HOME/.oh-my-zsh
ZSH_THEME="agnoster"
DISABLE_CORRECTION="true"

# Aliases
alias emacs="emacs -nw"
alias optipng-max="optipng -f0-5 -zc6-9 -i0 -zm6-9"

# Remove the beeps
setopt NO_BEEP

# Da plugins
plugins=(git shrink-path)

source $ZSH/oh-my-zsh.sh

# These things are tuned to agnoster. Note to self: Remember to remove these if
# I change to a different theme.
export DEFAULT_USER="$(whoami)"

prompt_dir() {
  prompt_segment blue $CURRENT_FG "$(shrink_path -f)"
}

prompt_timestamp() {
  DATE=$( date +"%H:%M:%S" )
  prompt_segment black default ${DATE}
}

build_prompt() {
  RETVAL=$?
  prompt_status
  prompt_virtualenv
  prompt_aws
  prompt_context
  prompt_timestamp
  prompt_dir
  prompt_git
  prompt_bzr
  prompt_hg
  prompt_end
}

# OPAM configuration
. /home/jeannikl/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
