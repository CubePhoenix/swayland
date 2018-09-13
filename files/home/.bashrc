#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

######## Added by swayland installer

# Alias git command to add ssh-key
alias git='~/.scripts/addgitkey.sh && git'
