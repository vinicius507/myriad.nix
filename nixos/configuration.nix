{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "42sp";
  boot.loader.systemd-boot.enable = true;

  nix = {
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
  };
  nixpkgs.config.allowUnfree = true;

  users.users = {
    vini = {
      isNormalUser = true;
      initialPassword = "strongpassword";
      extraGroups = [ "docker" "wheel" ];
    };
  };

  settings = {
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "22.11";
}
