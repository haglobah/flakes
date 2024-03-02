{
  outputs = { self }: {
    templates = {
      devshell = {
        path = ./templates/devshell;
        description = "A flake-parts flake with devshell set up";
      };
      elixir = {
        path = ./templates/elixir;
        description = "A flake-parts flake with devshell and elixir set up";
      };
      ocaml = {
        path = ./templates/ocaml;
        description = "A flake-parts flake with devshell and ocaml set up, based on 9glenda/ocaml-flake";
      };
      python = {
        path = ./templates/python;
        description = "A flake-parts flake with devshell and python set up – packages can be added via the 'standard' python way on Nix(OS)";
      };
      racket = {
        path = ./templates/racket;
        description = "A flake-parts flake with devshell and racket set up";
      };
      pollen = {
        path = ./templates/pollen;
        description = "A flake-parts flake with devshell, racket and pollen set up";
      };
      node = {
        path = ./templates/node;
        description = "A flake-parts flake with devshell and nodejs set up";
      };
      ruby = {
        path = ./templates/ruby;
        description = "A flake-parts flake with devshell and ruby set up";
      };
      deploy = {
        path = ./templates/deploy;
        description = "A flake-parts flake with devshell, vm and deployment capabilities set up";
      };
    };
  };
}