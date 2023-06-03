{ pkgs, ... }: {
  # here go the darwin preferences and config items
  users.users.seff = {
	name = "seff";
  	home = "/Users/seff";
  	packages = with pkgs; [
  	  mas
	  libarchive # Needed for opendrop
      streamlink
      llvm
  	];
  };
  programs.zsh.enable = true;
  environment = {
    shells = with pkgs; [ bash zsh ];
    loginShell = pkgs.zsh;
    systemPackages = [ pkgs.coreutils ];
    systemPath = [ "/opt/homebrew/bin" ];
    pathsToLink = [ "/Applications" ];
  };
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  # Vim users be like:
  #system.keyboard.enableKeyMapping = true;
  #system.keyboard.remapCapsLockToEscape = true;
  fonts.fontDir.enable = true; # DANGER
  fonts.fonts = [ (pkgs.nerdfonts.override { fonts = [ "Meslo" ]; }) ];
  services.nix-daemon.enable = true;
  system.defaults = {
    finder.AppleShowAllExtensions = true;
    finder._FXShowPosixPathInTitle = true;
    dock.autohide = true;
    NSGlobalDomain.AppleShowAllExtensions = true;
    NSGlobalDomain.InitialKeyRepeat = 14;
    NSGlobalDomain.KeyRepeat = 1;
  };
  # backwards compat; don't change
  system.stateVersion = 4;
  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    masApps = { };
    casks = [ "cakebrew" { name = "librewolf"; greedy = true; } "qbittorrent" "skim" { name = "eloston-chromium"; greedy = true; }  "keepassxc" "macfuse" "openconnect-gui" "restfox" "temurin" ];
    taps = [ "bradyjoslin/sharewifi" "louisbrunner/valgrind" "pirj/noclamshell" "winglim/taps" ];
    brews = [ ];

    # casks = [ "raycast" "amethyst" ];
    # taps = [ "fujiapple852/trippy" ];
    # brews = [ "trippy" ];
  };
}
