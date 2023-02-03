{ config, pkgs, ... }:
{
   programs.home-manager.enable = true;
   home.packages = with pkgs; [
     mpv
   ];
   programs.zsh.enable = true;
}
