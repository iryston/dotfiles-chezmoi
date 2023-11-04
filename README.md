# dotfiles

Personal dotfiles, managed with [`chezmoi`](https://github.com/twpayne/chezmoi).

Clone and install them with:

```bash
chezmoi init iryston/dotfiles-chezmoi --apply 
# or
chezmoi init iryston/dotfiles-chezmoi --ssh --apply
```

You can install chezmoi and dotfiles with the single command
```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply iryston/dotfiles-chezmoi.git
```
