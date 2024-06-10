{
  description = "A Haskell flake based on github:srid/haskell-template";

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/DeterminateSystems/nixpkgs-weekly/*.tar.gz";
    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {

      imports = [
        inputs.devshell.flakeModule
      ];

      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {

        devshells.default = {
          env = [

          ];

          packages = with pkgs; [
            pkgs.haskell.compiler."ghc94"
            pkgs.cabal-install
            pkgs.haskell.packages."ghc94".haskell-language-server
          ];

          devshell.startup = {
            # cabal-update.text = ''cabal update'';
          };
          commands = [
            { name = "cr"; command = "cabal run "; help = "Alias for 'cabal run'"; }
            { name = "cu"; command = "cabal update"; help = "'cabal update'"; }
          ];
        };

        packages.default = self'.packages.the-package;
      };
    };
}
