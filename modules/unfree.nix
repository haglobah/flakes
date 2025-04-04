{self, config, lib, pkgs, ... }:

{
  perSystem = {config, system, ...} : {
    _module.args.pkgs = import self.inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  };
}
