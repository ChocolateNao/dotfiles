#!/usr/bin/env bash

trap throw_error ERR

OS="$(uname -s)"

# Packages to install (space-separated)
package_list="ansible git ansible-lint"

source $(chezmoi source-path)/helpers/logger.sh

throw_error() {
    log_error 'An unexpected error occured. Exiting...'
    exit 1
}

install_on_fedora() {
    sudo dnf install -y $package_list_final
}

install_on_ubuntu() {
    sudo apt-get update && sudo apt-get install -y $package_list_final
}

install_on_mac() {
    brew install $package_list_final
}

install_on_arch() {
    sudo pacman -Syu --noconfirm && sudo pacman -S $package_list_final --noconfirm
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
    ansible-playbook -i $(chezmoi source-path)/dot_bootstrap/inventory.ini $(chezmoi source-path)/dot_bootstrap/playbook.yml --ask-become-pass
}

prompt_playbook() {
    read -p "Do you want to run ansible playbook to install dependencies? (yes/no) " response

    if [[ "$response" =~ ^[Yy] ]]; then
        log_info "Running ansible playbook..."
        run_playbook
    else
        log_error "Ansible playbook was not executed. Exiting..."
        exit 0
    fi
}

package_list_final="$package_list"

do_install() {
    for cmd in $package_list; do
        if command_exists "$cmd"; then
            # Remove the package name from the list
            package_list_final=$(echo "$package_list_final" | sed "s/\b$cmd\b//" | xargs)
            log_warn "$cmd already installed, skipping..."
        fi
    done

    if [ -z "$package_list_final" ]; then
        log_info "Package(s) \"$package_list\" already installed, skipping..."

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
                log_error "Unsupported distribution: ${dist}"
                exit 1
                ;;
        esac
    fi

    log_success "Package(s) \"$package_list\" installed successfully"

    # prompt_playbook
    exit 0
}

do_install
