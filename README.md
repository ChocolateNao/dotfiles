# My Personal dotfiles

🎏 That's how I do my dotfiles.

Managed with [chezmoi](https://www.chezmoi.io/).

## Installation

To install these on a new machine, you can use this one-liner

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
