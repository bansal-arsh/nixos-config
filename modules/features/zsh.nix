{...}: {
  flake.modules.homeManager.zsh = {...}: {
    programs.zsh = {
      enable = true;
      autosuggestion = {
        enable = true;
        strategy = ["history" "completion"];
      };
      history = {
        ignorePatterns = ["ls" "ls -*"];
        append = true;
        ignoreAllDups = true; # Removes older dupplicate commands
      };
      syntaxHighlighting = {
        enable = true;
        highlighters = ["main" "brackets"];
      };
    };
  };
}
