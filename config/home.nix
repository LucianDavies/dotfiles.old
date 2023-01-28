{pkgs, ...}: {
    home.username = "tonderai";
    home.homeDirectory = "/Users/tonderai";
    home.stateVersion = "23.05";
    programs.home-manager.enable = true;

    home.packages = [
      pkgs.ripgrep
    ];

    programs.neovim = {
      enable = true;
      extraConfig = "";
    };

    programs.tmux = {
      enable = true;
      shell = "${pkgs.zsh}/bin/zsh";
      extraConfig = "";
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
    userEmail = "5219738+LucianDavies@users.noreply.github.com";
    userName = "LucianDavies";
    extraConfig = {
      difftool.prompt = true;
      github.user = "LucianDavies";
      init.defaultBranch = "main";
      merge.conflictstyle = "diff3";
      mergetool.prompt = true;
      core.editor = "nvim";
      push.autoSetupRemote = true;
    };
  };
}