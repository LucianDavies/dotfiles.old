{pkgs, ...}: {
    home.username = "tonderai";
    home.homeDirectory = "/Users/tonderai";
    home.stateVersion = "23.05";
    programs.home-manager.enable = true;
    home.packages = [
      pkgs.ripgrep
    ];

    home.file.".config/nvim/init.lua".source = ./nvim/init.lua;
    programs.neovim = {
      enable = true;
    };

    programs.tmux = {
      enable = true;
      shell = "${pkgs.zsh}/bin/zsh";
      extraConfig = builtins.readFile ./tmux/tmux.conf;
    };

    programs.starship = {
      enable = true;
    };

    programs.zsh = {
      enable = true;
      enableAutosuggestions = true;
    };

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "rg --files --hidden --follow";
      defaultOptions = [ "-m --bind ctrl-a:select-all,ctrl-d:deselect-all" ];
    };

    
    programs.git = {
      enable = true;
      includes = [
        { path = "./git/gitconfig"; }
        {
          path = "./git/gitconfig-work";
          condition = "gitdir/i:work/";
        }
        {
          path = "./git/gitconfig-work";
          condition = "gitdir/i:dotfiles/";
        }
      ];
    };
}