{...}: {
  flake.modules.nixos.kde-plasma = {pkgs, ...}: {
    services = {
      desktopManager.plasma6.enable = true;
      displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };

      fprintd.enable = true;
    };

    programs.kdeconnect.enable = true;

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      kate
      ktexteditor
    ];
  };
}
