## Bash base16 material theme
![image](https://user-images.githubusercontent.com/9076315/43827849-2aa48b98-9afb-11e8-88df-eb1bfa18eaf2.png)

### Installation
- install [base16-shell](https://github.com/chriskempson/base16-shell)
```sh
git clone 'https://github.com/chriskempson/base16-shell.git' ~/.config/base16-shell
```

- add lines from `bash.sh` file to your `.bashrc` file (or similar)
```sh
curl 'https://raw.githubusercontent.com/polakowski/tools_and_utils/master/base16_material/bash.sh' >> ~/.zshrc
```

- copy `base16-material.sh` file to `/scripts` folder in `base16-shell` installation (default is `~/.config/base16-shell`)
```sh
curl 'https://raw.githubusercontent.com/polakowski/tools_and_utils/master/base16_material/base16-atom.sh' -o ~/.config/base16-shell/scripts/base16-material.sh
```

- refresh your terminal

### For ATOM users
If you use ATOM as your main IDE and you like this theme, you may like this: https://atom.io/packages/base16-material-syntax
