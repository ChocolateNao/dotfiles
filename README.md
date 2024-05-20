# My Personal dotfiles

🎏 That's how I do my dotfiles.

Managed with [chezmoi](https://www.chezmoi.io/) and [ansible](https://www.ansible.com/).

## Supported platforms

> [!IMPORTANT]
> `Not tested` here means that I haven't tested running playbook on this OS which means the process __will ignore errors__ during installation.

This repo supports package installation via ansible for the following operating systems and distributions.

_If you're willing to help testing unsupported things out - please do. It would be awesome!_

- [x] Linux
  - [x] Ubuntu
  - [x] Debian
  - [ ] Fedora (not tested)
  - [ ] Alpine (not tested)
  - [x] Arch
  - [x] Manjaro
<!-- - [ ] Windows (via chocolatey) (not tested) -->
- [ ] macOS (not tested)

If the command is executed on unsupported system the user will be prompted to skip the package-installation step and proceed to only install the dotfiles.

## Installation

To initiate installation on a new machine, you can use this one-liner. You will be prompted with some additional personal information such as name, email etc.

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply ChocolateNao
```

In case of a non-fresh install, usage of `--verbose` and `--dry-run` flags is highly recommend before making actual changes

```bash
# this installs chezmoi and initializes this repository
sh -c "$(curl -fsLS get.chezmoi.io)" -- init ChocolateNao

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
