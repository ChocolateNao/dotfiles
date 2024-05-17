#!/usr/bin/env bash

trap throw_error ERR

OS="$(uname -s)"

throw_error() {
    echo 'An unexpected error occured. Exiting...'
    exit 1
}

install_on_fedora() {
    sudo dnf install -y ansible
}

install_on_ubuntu() {
    sudo apt-get update && sudo apt-get install -y ansible
}

install_on_mac() {
    brew install ansible
}

install_on_arch() {
    sudo pacman -Syu --noconfirm && sudo pacman -S ansible --noconfirm
}

command_exists() {
    command -v $1 >/dev/null 2>&1
}

is_darwin() {
	case "${OS}" in
	*darwin* ) true ;;
	*Darwin* ) true ;;
	* ) false;;
	esac
}

is_linux() {
    case "${OS}" in
    *Linux* ) true ;;
    * ) false ;;
    esac
}

get_distribution() {
    dist=""
	# Every supported system has /etc/os-release
	if [ -r /etc/os-release ]; then
		dist="$(. /etc/os-release && echo "$ID")"
	fi
	# case statements don't act unless you provide an actual value
	echo "$dist"
}

run_playbook() {
    ansible-playbook $(chezmoi source-path)/dot_bootstrap/playbook.yml --ask-become-pass
}

prompt_playbook() {
    read -p "Do you want to run ansible playbook to install dependencies? (yes/no) " response

    if [[ "$response" =~ ^[Yy] ]]; then
        echo "Running ansible playbook..."
        run_playbook
    else
        echo "Ansible playbook was not executed. Exiting..."
        exit 0
    fi
}

do_install() {
    if command_exists ansible; then
        echo "Ansible already installed"

        # Now we are using playbook with "onchange" script
        # prompt_playbook
        exit 0
    fi

    if is_darwin; then
        install_on_mac
    elif is_linux; then
        dist=$(get_distribution)

        case "$dist" in
            manjaro|arch*)
                install_on_arch
                ;;
            centos|fedora|rhel*)
                install_on_fedora
                ;;
            ubuntu|debian*)
                install_on_ubuntu
                ;;
            *)
                echo "Unsupported distribution: ${dist}"
                exit 1
                ;;
        esac
    fi

    echo "Ansible installation complete"
    # prompt_playbook
}

do_install
