#!/bin/bash

# Choose between pinentry-tty and pinentry-x11 based on whether
# $PINENTRY_USER_DATA contains USE_TTY=1
#
# Note: Environment detection is difficult.
# - stdin is Assuan pipe, preventing tty checking
# - configuration info (e.g. ttyname) is passed via Assuan pipe, preventing
#   parsing or fallback without implementing Assuan protocol.
# - environment is sanitized by atfork_cb in call-pinentry.c (removing $GPG_TTY)

set -Ceu

# Use pinentry-tty if $PINENTRY_USER_DATA contains USE_TTY=1
case "${PINENTRY_USER_DATA-}" in
*USE_TTY=1*)
	# Note: Change to pinentry-curses if a Curses UI is preferred.
	exec pinentry-tty "$@"
	;;
esac

# Note: Will fall back to curses if $DISPLAY is not available.
exec "pinentry-gnome3" "$@"

