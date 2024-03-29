# uynix
one nix to rule them all

Based on @zmre 's awesome [tutorial](https://github.com/zmre/mac-nix-simple-example).  
Clone this project to home  
As of 01/2023, this bootstraps nix + home-manager + my flake from scratch  

## MacOS

- Install nix `sh <(curl -L https://nixos.org/nix/install)`
- Quit->Start Terminal(s)
- Install Homebrew
- MacOS <= 10.14: Change default shell to zsh: `chsh -s /bin/zsh`
```bash
nix build --extra-experimental-features "nix-command flakes" --show-trace uynix/.#darwinConfigurations.high-sierra.system
./result/sw/bin/darwin-rebuild switch --flake uynix/.#mojave #available: mojave, monterey
sudo rm /etc/nix/nix.conf /etc/shells
mv ~/.zshrc ~/.zshrc.before_nix
sudo mv /etc/zshrc /etc/zshrc.before_nix # There might be other problematic paths, just follow the installer
mv ~/.zshenv ~/.zshenv_before_nix
```
- Select `meslogs nf` font in iterm2 preferences

Notes:
* "iterm2" cask not working on MacOS <= 10.14
* "mpv" cask build doesn't support recent youtube updates on MacOS <= 10.14. Falling back to macports installation.
  (Yes, I justify 2GBs of dependencies because I **refuse** to compile homebrew libraries from source for every new update. Sue me)

## Linux

Make sure to install zsh with your package manager first AND set it as your default shell

```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
# Restart terminal(s)
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
sudo nano /etc/nix/nix.conf # Add: experimental-features = nix-command flakes
home-manager switch --flake ~/uynix/.#seff
```
