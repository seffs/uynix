{ config, pkgs, ... }: {
  # Relevant for some programs e.g. mpv
  fonts.fontconfig.enable = true;
  home.sessionVariables = {
    FONTCONFIG_FILE = "~/.config/fontconfig";
  };
  xdg.configFile."ytfzf" = {
    source = ./config/ytfzf/conf.sh;
    target = "ytfzf/conf.sh";
  };
  programs.zsh.enable = true;
}
