# Git command line completion
source /usr/local/Cellar/git/1.7.12/etc/bash_completion.d/git-completion.bash

# Git-aware prompt
export PS1='\[\033[01;32m\]\u\[\033[01;34m\] \w\[\033[31m\]$(git branch 2>/dev/null|cut -f2 -d\* -s) \[\033[01;34m\]$\[\033[00m\] '

# Aliases
alias ll='ls -laG'
alias ss='script/server'
alias sc='script/console'
alias stepfinder='bundle exec thor cucumber:stepfinder'
alias findstep='bundle exec thor cucumber:find_step'
alias rm_origs='find . -name "*.orig" | xargs rm'
alias p='cd /Users/rwrede/projects'
alias redis_start='/Users/rwrede/projects/metasearch/redis/src/redis-server'
alias bec='CAPYBARA_CHROME=yes bundle exec cucumber -r features/'
alias becf='bundle exec cucumber -r features/'
alias be='bundle exec'
alias pry_rails='be pry -r ./config/environment.rb'
alias rspec='bundle exec rspec'
alias guard='CAPYBARA_CHROME=yes be guard start'
alias gst='git status'
alias ci='git commit -m'
alias tmuxi='tmuxinator'
alias migrate='bundle exec rake db:migrate RAILS_ENV=test && bundle exec rake db:migrate'

function gnd
{
    growlnotify -m 'FEDDISCH!' --image '/Users/rwrede/Pictures/maja.png' -t 'Biene Maja sagt:'
}

function gpa
{
    cd /Users/rwrede/projects/adva-cms2 && git pull origin develop && cd -
    cd /Users/rwrede/projects/adva-shop && git pull origin develop && cd -
    cd /Users/rwrede/projects/adva-navision && git pull origin develop && cd -
    cd /Users/rwrede/projects/adva-cnet && git pull origin develop && cd -
}

export JAVA_HOME='/System/Library/Frameworks/JavaVM.framework/Home/'

##
# Your previous /Users/rwrede/.bash_profile file was backed up as /Users/rwrede/.bash_profile.macports-saved_2009-10-26_at_18:56:35
##

# MacPorts Installer addition on 2009-10-26_at_18:56:35: adding an appropriate PATH variable for use with MacPorts.
export PATH=/usr/local/Cellar/freetds/0.82/bin:/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

export GEMEDITOR='mate -w'
export EDITOR='mate -w'
export VIM_APP_DIR='/Applications/MacVim-7_3-53/'

bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'
# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth
# append to the history file, don't overwrite it
shopt -s histappend
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=10000
export HISTCONTROL=erasedups
shopt -s histappend

export PGDATA='/Users/rwrede/postgres/data'

function leo() {
 w3m -dump "http://pda.leo.org/?search=\"$*\"" | sed -n -e :a -e '1,9!{P;N;D;};N;ba' | sed -e '1,14d'
}
export VIMRUNTIME=/usr/share/vim/vim73
export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"
