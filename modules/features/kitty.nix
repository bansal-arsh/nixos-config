{...}: {
  flake.modules.homeManager.kitty = {pkgs, ...}: {
    programs.kitty = {
      enable = true;
      enableGitIntegration = true;
      font = {
        name = "Commit Mono";
        package = pkgs.nerd-fonts.commit-mono;
      };
      extraConfig = ''
        enable_audio_bell no
      '';
    };
  };
}
