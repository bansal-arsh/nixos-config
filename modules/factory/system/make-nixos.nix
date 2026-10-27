{
  inputs,
  lib,
  ...
}: {
  config.flake.factory.mkNixosSystem = {
    architecture,
    modules,
  }:
    inputs.nixpkgs.lib.nixosSystem {
      modules =
        [
          {nixpkgs.hostPlatform = lib.mkDefault architecture;}
          {nixpkgs.config.allowUnfree = lib.mkDefault true;}
        ]
        ++ modules;
    };
}
