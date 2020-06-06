#!/bin/sh
# This script creates monthly backups of the bash history file. Make sure you have
# HISTSIZE set to large number (more than number of commands you can type in every
# month). It keeps last 200 commands when it "rotates" history file every month.
# Typical usage in a bash profile:
#
# HISTSIZE=90000
# source ~/bin/history-backup
#
# And to search whole history use:
# grep xyz -h --color ~/.bash_history.*
#

KEEP=99999
BASH_HIST=~/.history
BACKUP=$BASH_HIST.$(date +%y%m)

if [ -s "$BASH_HIST" -a "$BASH_HIST" -nt "$BACKUP" ]; then
  # history file is newer then backup
  if [[ -f $BACKUP ]]; then
    # there is already a backup
    cp -f $BASH_HIST $BACKUP
  else
    # create new backup, leave last few commands and reinitialize
    cp -f $BASH_HIST $BACKUP
    # tail -n$KEEP $BACKUP > $BASH_HIST
    # history -r
  fi
fi
