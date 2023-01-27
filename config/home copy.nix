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
  home.stateVersion = "23.05";

  home.packages = [
    # pkgs is the set of all packages in the default home.nix implementation
    pkgs.nodejs
    pkgs.gh
    pkgs.ripgrep
    pkgs.azure-cli
    pkgs.azure-functions-core-tools
    pkgs.jq
    pkgs.python3
    pkgs.fzf

    # Rust
    pkgs.cargo
    pkgs.rustc
    pkgs.rustfmt

    pkgs.awscli
    pkgs.terraform

    pkgs.delta
    pkgs.diff-so-fancy
    pkgs.git-codeowners

    pkgs.python3
    pkgs.reattach-to-user-namespace

    pkgs.asciinema
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    shellAliases = {
      vim = "nvim";
      vi = "nvim";
    };


    initExtra = ''
      case $- in *i*)
        if [ -z "$TMUX" ]; then tmux attach -t $USER || tmux new -s $USER; fi;;
      esac
    '';
  };

  programs.starship = {
    enable = true;
  };

  programs.neovim = {
    enable = true;
  };

  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ./tmux/tmux.conf;
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

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "rg --files --hidden --follow";
    defaultOptions = [ "-m --bind ctrl-a:select-all,ctrl-d:deselect-all" ];
  };
  
  xdg.configFile."nvim" = {
    source = ./nvim;
    recursive = true;
  };
}
