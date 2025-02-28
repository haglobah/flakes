{
  description = "A project with a devshell, a vm config and a deployable system.";

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/DeterminateSystems/nixpkgs-weekly/*.tar.gz";

    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    nixpkgs,
    flake-parts,
    agenix,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        inputs.devshell.flakeModule
        # To import a flake module
        # 1. Add foo to inputs
        # 2. Add foo as a parameter to the outputs function
        # 3. Add here: foo.flakeModule
      ];
      systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin"];
      perSystem = {
        config,
        self',
        inputs',
        pkgs,
        system,
        ...
      }: {
        # Per-system attributes can be defined here. The self' and inputs'
        # module parameters provide easy access to attributes of the same
        # system.

        # Equivalent to  inputs'.nixpkgs.legacyPackages.hello;
        # packages.default = pkgs.hello;
        devshells.default = ./nix/devshell.nix;
      };
      flake = let
        system = "x86_64-linux";
      in {
        # The usual flake attributes can be defined here, including system-
        # agnostic ones like nixosModule and system-enumerating ones, although
        # those are more easily expressed in perSystem.
        nixosConfigurations = {
          your-system-name = nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
              ./nix/configuration.nix
              agenix.nixosModules.default
              {
                environment.systemPackages = [agenix.packages.${system}.default];
              }
            ];
          };
          test-vm = nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
              ./nix/configuration.nix
              ./nix/vm.nix
              agenix.nixosModules.default
              {
                environment.systemPackages = [agenix.packages.${system}.default];
              }
            ];
          };
        };
      };
    };
}
