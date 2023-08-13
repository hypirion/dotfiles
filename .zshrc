# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH=$HOME/.oh-my-zsh
ZSH_THEME="powerlevel10k/powerlevel10k"
DISABLE_CORRECTION="true"

source $ZSH/oh-my-zsh.sh

# Aliases
alias emacs="emacs -nw"
alias oxipng-max="oxipng -sao max -Z"

# Remove the beeps
setopt NO_BEEP

# OPAM configuration
[[ ! -r /home/jeannikl/.opam/opam-init/init.zsh ]] || source /home/jeannikl/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# fnm
export PATH=/home/jeannikl/.fnm:$PATH
eval "`fnm env`"
