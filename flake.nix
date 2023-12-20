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
      vm = {
        path = ./templates/vm;
        description = "A flake-parts flake with devshell and vm-building capabilities set up";
      };
    };
  };
}