{...}: {
  flake.modules.nixos.nh = {...}: {
    programs.nh = {
      enable = true;
      clean = {
        enable = true;
        dates = "monthly";
        extraArgs = "--keep 5 --keep-since 15d --keep-one";
      };
    };
  };
}
