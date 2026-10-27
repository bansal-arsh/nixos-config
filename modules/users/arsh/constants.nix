{lib, ...}: let
  username = "arsh";
  homeDir = "/home/${username}";
  constants-module = "_${username}-constants";
in {
  flake.modules.generic.${constants-module} = {
    options.${constants-module} = lib.mkOption {
      type = lib.types.attrsOf lib.types.unspecified;
      default = {};
    };

    config.${constants-module} = {
      nixos-config-dir = "${homeDir}/.dotfiles/nixos";
      github-ssh-key = "${homeDir}/.ssh/github_key_ed25519";
    };
  };
}
