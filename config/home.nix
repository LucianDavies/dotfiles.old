{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "tonderai";
  home.homeDirectory = "/Users/tonderai";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = [
    pkgs.ripgrep
    pkgs.plantuml
    pkgs.nodejs
    pkgs.jq
    pkgs.rustup
    pkgs.gh
    pkgs.azure-cli
    pkgs.azure-functions-core-tools
    pkgs.terraform
    pkgs.libxslt
  ];

  home.file.".config/nvim/init.lua".source = ./nvim/init.lua;
  home.file.".config/nvim/lua".source = ./nvim/lua;
  # home.file.".config/nvim/lua/snippets".source = ./nvim/snippets;

  programs.neovim = {
    enable = true;
    extraConfig = "";
  };


  # home.file.".config/tmux.conf".source = ./tmux/tmux.conf;
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

