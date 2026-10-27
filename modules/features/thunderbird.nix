{...}: {
  flake.modules.homeManager.thunderbird = {pkgs, ...}: {
    programs.thunderbird.enable = true;
    home.packages = [pkgs.mailspring];
  };
}
