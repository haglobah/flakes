{
  description = "flake-parts module that removes the unfree hassle";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs-lib.url = "github:NixOS/nixpkgs/nixos-unstable?dir=lib";
  };

  outputs =
    inputs @ {flake-parts, ... }:
    flake-parts.lib.mkFlake {inherit inputs;} (
      {flake-parts-lib, ... }:
      let
        inherit (flake-parts-lib) importApply;
      in
      {
        flake.flakeModule = importApply ./unfreeModule.nix {
          inherit flake-parts-lib;
          inherit (inputs) nixpkgs-lib;
        };
      }
    );
}
