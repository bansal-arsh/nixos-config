{...}: {
  flake.modules.homeManager.protonvpn = {pkgs, ...}: {
    home.packages = with pkgs; [wireguard-tools proton-vpn];
  };
}
