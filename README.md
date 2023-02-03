# minix
one nix to rule them all

Based on @zmre 's awesome [tutorial](https://github.com/zmre/mac-nix-simple-example).

On a new MacOS build, do the following:

- Install Homebrew
- Prior to 10.15: Change default shell to zsh: `chsh -s /bin/zsh`
- Clone this project to your home
- Execute `nix build --extra-experimental-features "nix-command flakes" --show-trace minix/.#darwinConfigurations.high-sierra.system`
- `./result/sw/bin/darwin-rebuild switch --flake minix/.#high-sierra`
- `sudo rm /etc/nix/nix.conf /etc/shells`
- `sudo mv ~/.zshrc ~/.zshrc.before_nix /etc/zshrc /etc/zshrc.before_nix`
- `mv ~/.zshenv ~/.zshenv_before_nix`
- `select meslogs nf in iterm2 preferences`
-Done!

Note: "iterm2" and "mpv" casks not working on MacOS <= 10.14
