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

    systemd.services.display-manager = {
      wants = ["fprintd.service"];
      after = ["fprintd.service"];
    };

    powerManagement.resumeCommands = ''
      sleep 2
      ${pkgs.systemd}/bin/systemctl restart fprintd.service
    '';

    programs.kdeconnect.enable = true;

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      kate
      ktexteditor
    ];
  };
}
