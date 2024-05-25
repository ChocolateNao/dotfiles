# My Personal dotfiles

🎏 That's how I do my dotfiles.

Managed with [chezmoi](https://www.chezmoi.io/) and [ansible](https://www.ansible.com/).

## Features

- [x] Various dotfiles listed in [/home](https://github.com/ChocolateNao/dotfiles/tree/master/home) directory
- [x] __zsh__ as default shell with __ohmyz.sh__ and the following plugins:
  - zsh-autosuggestions
  - zsh-syntax-highlighting
  - zsh-history-substring-search
- [x] Package installation via the built-in package manager (for supported platforms). You can find the base list [here](https://github.com/ChocolateNao/dotfiles/blob/master/home/dot_bootstrap/roles/packages/vars/main.yml)
- [x] __Python3__ with __pip__ globally
- [x] __Node.js__ LTS via __nvm__
- [x] Fonts:
  - JetBrains Mono
  - Fira Codee
  - MesloLGS NF

## Supported platforms

> [!IMPORTANT]
> `Not tested` here means that I haven't tested running playbook on this OS which means the process __will ignore errors__ during installation.

This repo supports package installation via ansible for the following operating systems and distributions.

_If you're willing to help testing unsupported things out - please do and let me know. It would be awesome!_

- [x] Linux
  - [x] Ubuntu
  - [x] Debian
  - [ ] Fedora _(Not tested)_
  - [ ] Alpine _(Not tested)_
  - [x] Arch
  - [x] Manjaro
<!-- - [ ] Windows (via chocolatey) (not tested) -->
- [ ] macOS _(Not tested)_

If the command is executed on unsupported system the user will be prompted to skip the package-installation step and proceed to install dotfiles only.

## Installation

To initiate installation on a new machine, you can use this one-liner. You will be prompted with some additional personal information such as name, email etc.

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply ChocolateNao
```

In case of a non-fresh install, usage of `--verbose` and `--dry-run` flags is highly recommend before making actual changes

```bash
# this installs chezmoi and initializes this repository
sh -c "$(curl -fsLS get.chezmoi.io)" -- init ChocolateNao

# If not installed globally, the exec might be different
# /home/$USER/bin/chezmoi

# look what will be changed
chezmoi apply --verbose --dry-run

# apply changes
chezmoi apply --verbose
```

## File sctructure

```sh
└── 📁chezmoi
    └── .chezmoiroot # Defines "./home" as root dir
    └── .chezmoiversion # The minimal version on which the installation starts
    └── 📁home
        └── .chezmoi.toml.tmpl # Config file template. Executed on "init"
        └── .chezmoidata.toml # Additional data to "chezmoi data"
        └── 📁.chezmoiexternals # External package installation scripts
        └── .chezmoiignore # List of files that chezmoi will ignore
        └── 📁.chezmoiscripts # Main scripts. Executed in order from "00"
        └── 📁.chezmoitemplates # Reusable templates
        └── 📁dot_bootstrap # Everything related to ansible lives here
        └── 📁helpers # Utility scripts
        └── dot_* # Managed dotfiles (check with "chezmoi managed --tree")
```

## Personal use

The ansible playbook contains a set of packages I personally prefer to have on my machine. This can be updated over time and may not fit your expectations. However, the script is quite versatile and, with minor adjustments, can be used on any machine. To achieve this, consider forking this repository and making changed inside your fork. You can refer to [file structure](#file-sctructure) if needed.

## Roadmap

- [x] Packages
- [x] oh my zsh
- [x] Node & nvm
- [x] Fonts
- [ ] Docker in rootless mode
- [ ] Private keys
