{
  inputs = {
    nixpkgs.url = "https://flakehub.com/f/DeterminateSystems/nixpkgs-weekly/*.tar.gz";
    flake-parts.url = "github:hercules-ci/flake-parts";
    pre-commit-hooks.url = "github:cachix/git-hooks.nix";
    devshell.url = "github:numtide/devshell";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        inputs.devshell.flakeModule
        inputs.pre-commit-hooks.flakeModule
      ];
      systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin"];
      perSystem = {config, ...}: {
        pre-commit = {
          settings.hooks = {
            alejandra.enable = true;
            # deadnix.enable = true;
          };
        };
        devshells.default = {
          devshell = {
            startup = {
              pre-commit.text = config.pre-commit.settings.installationScript;
            };
          };
        };
      };
      flake = {
        templates = {
          base = {
            path = ./templates/base;
            description = "flake-parts with devshell";
          };
          basic-home-manager = {
            path = ./templates/basic-home-manager;
            description = "flake with a simple home-manager configuration";
          };
          cljs = {
            path = ./templates/cljs;
            description = "flake-parts flake with nodejs, shadow-cljs and java";
          };
          cljs-template = {
            path = ./templates/cljs-template;
            description = "shadow-cljs starter project with flake-parts, nodejs, shadow-cljs and java";
          };
          clojure = {
            path = ./templates/clojure;
            description = "flake-parts with devshell and clojure";
          };
          clojure-template = {
            path = ./templates/clojure-template;
            description = "flake-parts with devshell, clojure, and clj-nix";
          };
          cpp = {
            path = ./templates/cpp;
            description = "flake-parts with devshell and C++";
          };
          deploy = {
            path = ./templates/deploy;
            description = "flake-parts with devshell, vm and deployment capabilities";
          };
          elixir = {
            path = ./templates/elixir;
            description = "flake-parts with devshell and elixir";
          };
          haskell = {
            path = ./templates/haskell;
            description = "flake-parts with devshell, ghc, cabal and hls";
          };
          haskell-template = {
            path = ./templates/haskell-template;
            description = "flake-parts with devshell and haskell, based on srid/haskell-flake";
          };
          node = {
            path = ./templates/node;
            description = "flake-parts with devshell and nodejs";
          };
          ocaml = {
            path = ./templates/ocaml;
            description = "flake-parts with devshell and ocaml, based on 9glenda/ocaml-flake";
          };
          phoenix = {
            path = ./templates/phoenix;
            description = "flake-parts with devshell, elixir and node";
          };
          pollen = {
            path = ./templates/pollen;
            description = "flake-parts with devshell, racket and pollen";
          };
          pollen-template = {
            path = ./templates/pollen-template;
            description = "pollen starter project with flake-parts, devshell, racket and pollen";
          };
          python = {
            path = ./templates/python;
            description = "flake-parts with devshell and python – packages can be added via the 'standard' python way on Nix(OS)";
          };
          racket = {
            path = ./templates/racket;
            description = "flake-parts with devshell and racket";
          };
          ruby = {
            path = ./templates/ruby;
            description = "flake-parts with devshell and ruby";
          };
          slidev-bare = {
            path = ./templates/slidev-bare;
            description = "slidev starter project without flake";
          };
          slidev-separate = {
            path = ./templates/slidev-separate;
            description = "slidev starter project with nodejs flake";
          };
        };
      };
    };
}
