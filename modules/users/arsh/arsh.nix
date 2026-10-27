{
  self,
  lib,
  ...
}: let
  username = "arsh";
  constants-module = "_${username}-constants";
in {
  flake.modules = lib.mkMerge [
    (self.factory.mkUser {
      inherit username;
      isAdmin = true;
      shellPackageName = "zsh";

      nixosModules = with self.modules.nixos; [
        brave
        kde-plasma
        nh
        trash
        keyd
        qemu
        racket
      ];

      homeManagerModules = with self.modules.homeManager; [
        git
        ssh
        kitty
        neovim
        tealdeer
        zsh
        ripgrep
        direnv
        wget
        pay-respects
        protonvpn
        thunderbird
      ];
    })

    {
      nixos.${username} = {
        users.users.${username} = {
          extraGroups = [
            "networkmanager"
            "kvm"
          ];
        };

        # Set your time zone.
        time.timeZone = "America/Toronto";

        # Select internationalisation properties.
        i18n.defaultLocale = "en_CA.UTF-8";
        # console = {
        #   font = "Lat2-Terminus16";
        #   keyMap = "us";
        #   useXkbConfig = true; # use xkb.options in tty.
        # };
      };
    }

    {
      homeManager.${username} = {config, ...}: {
        imports = [self.modules.generic.${constants-module}];

        home.sessionVariables = {
          NH_FLAKE = config.${constants-module}.nixos-config-dir;
        };

        programs.ssh.settings = {
          "github.com" = {
            HostName = "github.com";
            User = username;
            IdentityFile = config.${constants-module}.github-ssh-key;
          };
        };
      };
    }
  ];
}
