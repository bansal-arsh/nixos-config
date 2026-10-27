{self, ...}: {
  config.flake.factory.mkUser = {
    username,
    isAdmin ? false,
    shellPackageName ? "zsh",
    nixosModules,
    homeManagerModules,
  }: {
    nixos.${username} = {
      pkgs,
      lib,
      ...
    }: {
      imports = [self.modules.nixos.home-manager] ++ nixosModules;

      users.users.${username} = {
        description = lib.toSentenceCase username;
        isNormalUser = true;
        home = "/home/${username}";
        extraGroups = lib.optionals isAdmin [
          "wheel"
        ];
        shell = pkgs.${shellPackageName};
      };
      programs.${shellPackageName}.enable = true;

      home-manager.users.${username}.imports = [
        self.modules.homeManager.${username}
      ];
    };

    homeManager.${username} = {
      imports = homeManagerModules;
      home.username = "${username}";
      home.homeDirectory = "/home/${username}";
    };
  };
}
