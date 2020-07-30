# Git
alias gs='git status'
alias amend='git commit --amend'
alias gad='git add .'
alias gco='git commit'
alias gd='git diff'
alias gdc='git diff --cached'
alias gpwl='git push --force-with-lease'
alias gmp='git checkout master && git pull'
alias gmpc='gmp && git checkout -'

# misc
alias l='ls -lha'

# ruby specific
alias be='bundle exec'

# karnov
alias mario='cd ~/code/karnov/mario'
alias karnov='cd ~/code/karnov'

# Zip files
extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1    ;;
            *.tar.gz)    tar xvzf $1    ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar x $1     ;;
#            *.gz)        gunzip $1      ;;
            *.gz)        tar xvf $1      ;;
            *.tar)       tar xvf $1     ;;
            *.tbz2)      tar xvjf $1    ;;
            *.tgz)       tar xvzf $1    ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)           echo "don't know how to extract '$1'..." ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}
