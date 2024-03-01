{
  description = "Ocaml project using `ocaml-flake` and `flake-parts`";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    ocaml-flake.url = "github:9glenda/ocaml-flake";
  };

  outputs = inputs @ {
    flake-parts,
    ocaml-flake,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        ocaml-flake.flakeModule
      ];
      systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin"];
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        ocaml = {
          duneProjects = {
            default = {
              name = "my_package";
              src = ./.;
            };
          };
        };
      };
      flake = {
        # The usual flake attributes can be defined here, including system-
        # agnostic ones like nixosModule and system-enumerating ones, although
        # those are more easily expressed in perSystem.

      };
    };
}
