{...}: {
  flake.modules.homeManager.pay-respects = {
    programs.pay-respects = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      options = [
        "--alias"
        "fuck"
      ];
    };
  };
}
