{...}: {
  flake.modules.nixos.keyd = {
    services.keyd = {
      enable = true;
      keyboards.default = {
        ids = ["*"];
        settings = {
          global = {
            chord_timeout = 20;
          };
          main = {
            "leftmeta+leftshift+f23" = "rightcontrol"; # remap copilot key to right control
          };
        };
      };
    };
  };
}
