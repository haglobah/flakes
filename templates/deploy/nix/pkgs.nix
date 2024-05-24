{ config, lib, pkgs, ...}:
{
  imports = [];
  options = {
    self-packages = lib.mkOption {
      description = "The standard packages this project needs";

      type = lib.types.anything;
    };
  };
  
  config = {
    self-packages = with pkgs; [
      gnumake
      gcc
    ];
  };
}