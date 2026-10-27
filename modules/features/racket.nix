{self, ...}: {
  flake.modules.nixos.racket = {...}: {
    imports = [self.modules.nixos.nix-flatpak];

    services.flatpak.packages = [
      "org.racket_lang.Racket"
    ];
  };
}
