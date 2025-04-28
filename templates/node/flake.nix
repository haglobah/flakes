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
      perSystem = {
        config,
        pkgs,
        ...
      }: {
        pre-commit = {
          settings.hooks = {
            alejandra.enable = false;
            deadnix.enable = false;
          };
        };
        # Equivalent to  inputs'.nixpkgs.legacyPackages.hello;
        # packages.default = pkgs.hello;
        devshells.default = {
          env = [
            # { name = "MY_ENV_VAR"; value = "SOTRUE"; }
          ];
          commands = [
          ];
          devshell = {
            packagesFrom = [
            ];
            packages = [
              pkgs.nodejs_22
            ];
          };
        };
      };
      flake = {
      };
    };
}
