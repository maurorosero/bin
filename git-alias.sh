#!/bin/bash
######################################################################
#
#  git-alias.sh
#
#  Set alias to frequently used commands
#
#
######################################################################

# Revertier el area de trabajo al último commit
git config --global alias.reset-hard '!git reset --hard HEAD && git clean -fd'

#git config --global alias.revert-last 'revert HEAD'
