{...}: {
  flake.modules.nixos.qemu = {pkgs, ...}: {
    environment.systemPackages = [pkgs.qemu];
  };
}
