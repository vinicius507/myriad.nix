{ config, pkgs, ... }: {
  home.username = "vini";
  home.homeDirectory = "/home/vini";

  programs.home-manager.enable = true;
  programs.fish = {
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

  programs.neovim = {
    enable = true;
    vimAlias = true;
    defaultEditor = true;
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
