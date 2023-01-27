{pkgs, ...}: {
    home.username = "tonderai";
    home.homeDirectory = "/Users/tonderai";
    home.stateVersion = "23.05";
    programs.home-manager.enable = true;

    programs.starship = {
      enable = true;
    };

    programs.zsh = {
      enable = true;
    };
}