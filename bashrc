
# Preserve bash history in multiple terminal windows
export HISTCONTROL=ignoredups:erasedups:ignorespace
export HISTIGNORE='ls:bf:fg:history:l:sound:dock:undock:headphones:top:l:mocp:rm'
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it

# Save and reload the history after each command finishes
export PROMPT_COMMAND='history -a'
# export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# all my aliases
if test -f ~/.bash_aliases; then . ~/.bash_aliases; fi

# bash completion
if test -f /etc/bash_completion; then . /etc/bash_completion; fi
# TODO
# if test -f $HOME/git/dotfiles/bash_completion/tma; then . $HOME/git/dotfiles/bash_completion/tma; fi
# if test -f $HOME/git/dotfiles/bash_completion/tmk; then . $HOME/git/dotfiles/bash_completion/tmk; fi

# Extend $PATH environment

# Pip installed packages
if test -d "$HOME/.local/bin"; then PATH="$HOME/.local/bin:$PATH"; fi

# Gem installed packages
# TODO Make it non-version specific
# rubyver=2.7.1
# TODO
# if test -d "$HOME/.rbenv/"; then PATH="$HOME/.rbenv/bin:$PATH"; fi
# if test -d "$HOME/.rbenv/"; then PATH="$HOME/.rbenv/versions/$rubyver/bin:$PATH"; fi
# if test -d "$HOME/.gem/"; then PATH="$HOME/.gem/ruby/$rubyver/bin:$PATH"; fi

# Global bins
if test -d "/opt/bin"; then PATH="/opt/bin:$PATH"; fi
if test -d "/opt/sbin"; then PATH="/opt/sbin:$PATH"; fi
if test -d "/snap/bin"; then PATH="/snap/bin:$PATH"; fi

# if custom vim
if test -d "$HOME/opt/vim"; then PATH="$HOME/opt/vim/bin:$PATH"; fi

# My own bins
if test -d "$HOME/bin"; then PATH="$HOME/bin:$PATH"; fi

# Actually, just overwrite python
if test -d "$HOME/opt/anaconda3"; then PATH="$HOME/opt/anaconda3/bin:$PATH"; fi
if test -d "$HOME/opt/miniconda3"; then PATH="$HOME/opt/miniconda3/bin:$PATH"; fi

# if git
if test -d "$HOME/opt/git"; then PATH="$HOME/opt/git/bin:$PATH"; fi
if test -f "$HOME/.git-prompt.sh"; then source $HOME/.git-prompt.sh; fi

# Others Shortcuts
alias ls='ls --color'

# I would like to have colours in my terminal
if test $TERM == "xterm"; then export TERM=xterm-256color; fi


# PS1
#
# 0;30m   Black
# 0;31m   Red
# 0;32m   Green
# 0;33m   Yellow
# 0;34m   Blue
# 0;35m   Purple
# 0;36m   Cyan
# 0;37m   White

# http://mediadoneright.com/content/ultimate-git-ps1-bash-prompt

#  Customize BASH PS1 prompt to show current GIT repository and branch.
#  by Mike Stewart - http://MediaDoneRight.com

#  SETUP CONSTANTS
#  Bunch-o-predefined colors.  Makes reading code easier than escape sequences.
#  I don't remember where I found this.  o_O

# Reset
Color_Off="\[\033[0m\]"       # Text Reset

# Regular Colors
Black="\[\033[0;30m\]"        # Black
Red="\[\033[0;31m\]"          # Red
Green="\[\033[0;32m\]"        # Green
Yellow="\[\033[0;33m\]"       # Yellow
Blue="\[\033[0;34m\]"         # Blue
Purple="\[\033[0;35m\]"       # Purple
Cyan="\[\033[0;36m\]"         # Cyan
White="\[\033[0;37m\]"        # White

# Background
# On_Black="\[\033[40m\]"       # Black
# On_Red="\[\033[41m\]"         # Red
# On_Green="\[\033[42m\]"       # Green
# On_Yellow="\[\033[43m\]"      # Yellow
# On_Blue="\[\033[44m\]"        # Blue
# On_Purple="\[\033[45m\]"      # Purple
# On_Cyan="\[\033[46m\]"        # Cyan
# On_White="\[\033[47m\]"       # White

# Various variables you might want for your PS1 prompt instead
Time12h="\T"
Time12a="\@"
PathShort="\w"
PathFull="\W"
NewLine="\n"
Jobs="\j"

# export PS1="$Blue\h$Color_Off $Cyan\W$Color_Off"

case $HOSTNAME in
    laptop )
        export PS1="$Blue\h $Cyan\W$Color_Off";;
    * )
        export PS1="$Yellow\h$Color_Off $Cyan\W$Color_Off";;
esac

# If this is on interactive node, change color
if test ! -z $JOB_ID; then
    export PS1="$Red\h $Cyan\W$Color_Off"
fi

if [ -z "$PS1NOGIT" ]
then
export PS1="$PS1"'$(git branch &>/dev/null;\
if [ $? -eq 0 ]; then \
  echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
  if [ "$?" -eq "0" ]; then \
    # @4 - Clean repository - nothing to commit
    echo "'$Green'"$(__git_ps1 " (%s)"); \
  else \
    # @5 - Changes to working tree
    echo "'$Red'"$(__git_ps1 " {%s}"); \
  fi)"; \
fi)'

fi

export PS1=$PS1"$Color_Off \$ "

# If this is an xterm set the title to user@host:dir
case "$TERM" in xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\w\a\]$PS1"
    ;;
*)
    ;;
esac

# fuzzy search
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# intel

if test -d $HOME/intel/licenses; then
    for x in $HOME/intel/licenses/*.lic; do
        export INTEL_LICENSE_FILE=$x
    done
    source $HOME/intel/bin/compilervars.sh intel64
fi

# Don't send me messages
mesg n

if test -f $HOME/.bashrc_local; then source $HOME/.bashrc_local; fi

# Setup conda generally
if test -d "$HOME/opt/anaconda3"; then CONDA_PREFIX="$HOME/opt/anaconda3"; fi
if test -d "$HOME/opt/miniconda3"; then CONDA_PREFIX="$HOME/opt/miniconda3"; fi
__conda_setup="$('$CONDA_PREFIX/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$CONDA_PREFIX/etc/profile.d/conda.sh" ]; then
        . "$CONDA_PREFIX/etc/profile.d/conda.sh"
    else
        export PATH="$CONDA_PREFIX/bin:$PATH"
    fi
fi
unset __conda_setup

