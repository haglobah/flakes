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
      racket = {
        path = ./templates/racket;
        description = "A flake-parts flake with devshell and racket set up";
      };
      node = {
        path = ./templates/node;
        description = "A flake-parts flake with devshell and nodejs set up";
      };
      deploy = {
        path = ./templates/deploy;
        description = "A flake-parts flake with devshell, vm and deployment capabilities set up";
      };
    };
  };
}