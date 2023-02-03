{ config, pkgs, ... }:
{
   programs.home-manager.enable = true;
   home.packages = with pkgs; [
     mpv
   ];
   environment = {
     shells = with pkgs; [ bash zsh ];
     loginShell = pkgs.zsh;
   };
}
