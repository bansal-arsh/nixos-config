{...}: {
  flake.modules.homeManager.neovim = {pkgs, ...}: {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      plugins = with pkgs.vimPlugins; [
        nvim-web-devicons

        telescope-nvim
        nvim-treesitter.withAllGrammars
        nvim-lspconfig
        blink-cmp
        conform-nvim
        nvim-lint

        undotree
        nvim-lsp-file-operations
        nvim-autopairs
        gitsigns-nvim
        which-key-nvim
        nvim-tree-lua
        oil-nvim

        themery-nvim
        cyberdream-nvim
        lualine-nvim
        indent-blankline-nvim

        typst-preview-nvim
        vim-be-good
      ];
      extraPackages = with pkgs; [
        fd
        nixd
        tinymist
        gopls
        lua-language-server
        basedpyright
        superhtml
        alejandra
        stylua
        prettier
        prettierd
        ruff
      ];
    };

    xdg.enable = true;
    xdg.configFile.nvim = {
      source = ./lua-config;
      recursive = true;
    };
  };
}
