#!/usr/bin/env bash

# Colors
RED="\033[0;31m"
GREEN_BOLD="\033[1;32m"
YELLOW="\033[0;33m"
WHITE="\033[0;97m"
WHITE_BOLD="\033[1;97m"
NORMAL="\033[m"

# Do not use this function outside
_base() {
    for arg in "$@"; do
        echo -e "$arg${NORMAL}"
    done
}

log_info() {
    _base "${WHITE_BOLD}[ ~ ] $@"
}

log_warn() {
    _base "${YELLOW}[ ! ] $@"
}

log_error() {
    _base "${RED}[ - ] $@"
}

log_success() {
    _base "${GREEN_BOLD}[ + ] $@"
}