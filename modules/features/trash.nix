{...}: {
  flake.modules.nixos.trash = {pkgs, ...}: {
    environment.systemPackages = [pkgs.trash-cli];
  };
}
