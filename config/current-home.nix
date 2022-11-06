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
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;


  programs.starship = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    enableVteIntegration = pkgs.stdenv.isLinux;
    autocd = true;
    dotDir = ".config/zsh";
    history = {
      expireDuplicatesFirst = true;
      extended = true;
      ignoreDups = true;
      path = "${config.xdg.dataHome}/zsh/history";
      save = 10000;
      share = true;
    };
    envExtra = ''
      export LESSHISTFILE="${config.xdg.dataHome}/less_history"
      export CARGO_HOME="${config.xdg.cacheHome}/cargo"
    '';
    initExtra = ''
      nix-closure-size() {
        nix-store -q --size $(nix-store -qR $(${pkgs.coreutils}/bin/readlink -e $1) ) |
          ${pkgs.gawk}/bin/gawk '{ a+=$1 } END { print a }' |
          ${pkgs.coreutils}/bin/numfmt --to=iec-i
      }
      bindkey "$${terminfo[khome]}" beginning-of-line
      bindkey "$${terminfo[kend]}" end-of-line
      bindkey "$${terminfo[kdch1]}" delete-char
      bindkey '\eOA' history-substring-search-up
      bindkey '\eOB' history-substring-search-down
      bindkey "^[[A" history-substring-search-up
      bindkey "^[[B" history-substring-search-down
      bindkey "$$terminfo[kcuu1]" history-substring-search-up
      bindkey "$$terminfo[kcud1]" history-substring-search-down
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;3C" forward-word
      bindkey "^[[1;5D" backward-word
      bindkey "^[[1;3D" backward-word
      bindkey -s "^O" 'fzf | xargs -r $VISUAL^M'
      bindkey -rpM viins '^[^['
      KEYTIMEOUT=1
      ${pkgs.any-nix-shell}/bin/any-nix-shell zsh | source /dev/stdin
    '';
    sessionVariables = {
      RPROMPT = "";
    };
    plugins = [
      {
        # https://github.com/softmoth/zsh-vim-mode
        name = "zsh-vim-mode";
        file = "zsh-vim-mode.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "softmoth";
          repo = "zsh-vim-mode";
          rev = "abef0c0c03506009b56bb94260f846163c4f287a";
          sha256 = "0cnjazclz1kyi13m078ca2v6l8pg4y8jjrry6mkvszd383dx1wib";
        };
      }
      {
        # https://github.com/hlissner/zsh-autopair
        name = "zsh-autopair";
        file = "zsh-autopair.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "hlissner";
          repo = "zsh-autopair";
          rev = "34a8bca0c18fcf3ab1561caef9790abffc1d3d49";
          sha256 = "1h0vm2dgrmb8i2pvsgis3lshc5b0ad846836m62y8h3rdb3zmpy1";
        };
      }
      {
        # https://github.com/zsh-users/zsh-history-substring-search
        name = "zsh-history-substring-search";
        file = "zsh-history-substring-search.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-history-substring-search";
          rev = "0f80b8eb3368b46e5e573c1d91ae69eb095db3fb";
          sha256 = "0y8va5kc2ram38hbk2cibkk64ffrabfv1sh4xm7pjspsba9n5p1y";
        };
      }
    ];
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
    };
  };

  programs.neovim = {
    enable = true;
  };

  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    baseIndex = 1;
    terminal = "screen-256color";
    clock24 = true;
    customPaneNavigationAndResize = true;
    escapeTime = 0;
    historyLimit = 50000;
    keyMode = "vi";
    shortcut = "Space";
  };

  xdg.configFile."nvim/lua".source = ./nvim/lua;
  xdg.configFile."nvim/init.lua".source = ./nvim/init.lua;
  xdg.configFile."tmux/tmux.conf".source = ./tmux/tmux.conf;
}
