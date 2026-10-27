{...}: {
  flake.modules.homeManager.git = {...}: {
    programs.git = {
      enable = true;
      settings = {
        user.name = "Arsh Bansal";
        user.email = "arshbansal1111@gmail.com";
        init.defaultBranch = "main";
      };
    };
  };
}
