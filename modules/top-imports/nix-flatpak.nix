{inputs, ...}: {
  flake-file.inputs = {
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
  };

  flake.modules.nixos.nix-flatpak = {
    imports = [
      inputs.nix-flatpak.nixosModules.nix-flatpak
    ];

    services.flatpak = {
      enable = true;
      update.auto = {
        enable = true;
        onCalendar = "Sat";
      };
      uninstallUnmanaged = true;
    };
  };
}
