# { pkgs, pwnvim, ... }: {
let 
  # My pl10k config
  myPl10k = {
    configThemeNormal = ./p10k-config/p10k.zsh;
    configThemeTTY = ./p10k-config/p10k_tty.zsh;
  };
in
{ pkgs, ... }: {
  # Don't change this when you change package input. Leave it alone.
  home.stateVersion = "22.11";
  # specify my home-manager configs
  home.packages = with pkgs; [
    asciiquarium
    mas
    ncdu
    ncspot
    neofetch
    nmap
    nodejs
    rustup
    somafm-cli
    timg
    tmux
    htop
    btop
    freerdp
    ytfzf
    virt-manager
    libvirt
    qemu
    gnupg
    python3Full
    # Essentials
    ripgrep
    fd
    curl
    less
    nano
    wget
    # pwnvim.packages."x86_64-darwin".default
    # Meslo Nerd Font patched for Powerlevel10k
    # Restart iTerm2 and configure it (profile) to choose MesloLGS NF
    meslo-lgs-nf 
  ];
  home.sessionVariables = {
    PAGER = "less";
    CLICLOLOR = 1;
    EDITOR = "nano";
    FONTCONFIG_FILE = "~/.config/fontconfig";
  };
  xdg.configFile."ytfzf" = {
    source = ./config/ytfzf/conf.sh;
    target = "ytfzf/conf.sh";
  };
  xdg.configFile."mpv" = {
    source = ./config/mpv/mpv.conf;
    target = "mpv/mpv.conf";
  };
  #programs.bat.enable = true;
  #programs.bat.config.theme = "TwoDark";
  fonts.fontconfig.enable = true;
  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;
  # Relevant for virt-manager
  #dconf.enable = true;
  #gtk.enable = true;
  #gtk.theme.name = "Adwaita";
  #
  programs.exa.enable = true;
  programs.git.enable = true;
  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.enableAutosuggestions = true;
  programs.zsh.enableSyntaxHighlighting = true;
  programs.zsh.shellAliases = {
    ls = "ls --color=auto -F";
    # Actually good, but I prefer some little suffering in order to remember it
    #nixswitch = "darwin-rebuild switch --flake ~/src/system-config/.#";
    #nixup = "pushd ~/src/system-config; nix flake update; nixswitch; popd";
  };
  programs.zsh.initExtra = ''
      # The powerlevel theme I'm using is distgusting in TTY, let's default
      # to something else
      # See https://github.com/romkatv/powerlevel10k/issues/325
      # Instead of sourcing this file you could also add another plugin as
      # this, and it will automatically load the file for us
      # (but this way it is not possible to conditionally load a file)
      # {
      #   name = "powerlevel10k-config";
      #   src = lib.cleanSource ./p10k-config;
      #   file = "p10k.zsh";
      # }
      if zmodload zsh/terminfo && (( terminfo[colors] >= 256 )); then
        [[ ! -f ${myPl10k.configThemeNormal} ]] || source ${myPl10k.configThemeNormal}
      else
        [[ ! -f ${myPl10k.configThemeTTY} ]] || source ${myPl10k.configThemeTTY}
      fi
  '';
  programs.zsh.plugins = [
      {
        # A prompt will appear the first time to configure it properly
        # make sure to select MesloLGS NF as the font in iTerm2
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
  ];
  # Interesting stuff for later...
  #programs.starship.enable = true;
  #programs.starship.enableZshIntegration = true;
  #programs.alacritty = {
  #  enable = true;
  #  settings.font.normal.family = "MesloLGS Nerd Font Mono";
  #  settings.font.size = 16;
  #};
  home.file.".inputrc".source = ./dotfiles/inputrc;
}
