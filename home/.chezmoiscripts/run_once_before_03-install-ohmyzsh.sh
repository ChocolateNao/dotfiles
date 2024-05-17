#!/usr/bin/env bash

source $(chezmoi source-path)/helpers/logger.sh

if [ ! -d "$HOME/.oh-my-zsh" ]; then
	log_info "Installing ohmyz.sh"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc --skip-chsh
else
	log_warn ".oh-my-zsh already installed, skipping..."
fi
