{ config, pkgs, ... }: {
  home.username = "vini";
  home.homeDirectory = "/home/vini";

  home.packages = with pkgs; [
    bat
    gh
    git-crypt
    kubectl
    ripgrep
    zoxide
  ];

  home.file = {
    ".ssh/keys/" = {
      source = ./config/ssh;
      recursive = true;
    };
    ".kube/config".source = ./config/kube/config;
  };

  programs = {
    home-manager.enable = true;

    fish = {
      enable = true;
      interactiveShellInit =
        ''
          set acceptable_terms xterm-256color screen256-color xterm-termite

          if contains $TERM $acceptable_terms
              fish_vi_key_bindings
          end

          zoxide init fish | source
          starship init fish | source
        '';
    };
    git = {
      enable = true;

      userName = "Vinicius Oliveira";
      userEmail = "vinicius@myriad.codes";

      extraConfig = {
        github.user = "vinicius507";
      };
    };
    neovim = {
      enable = true;
      vimAlias = true;
      defaultEditor = true;
    };
    ssh = {
      enable = true;
      matchBlocks = {
        "*.42sp.org.br" = {
          port = 4222;
          identityFile = "${config.home.homeDirectory}/.ssh/keys/id_ed25519";
        };
      };
    };
  };

  xdg.configFile = {
    nvim = {
      source =
        config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/.config/home-manager/config/nvim";
      recursive = true;
    };
  };

  targets.genericLinux.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.
}
