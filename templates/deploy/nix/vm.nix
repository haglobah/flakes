{ config, modulesPath, ... }:
{
  imports = [
    "${modulesPath}/virtualisation/qemu-vm.nix"
  ];

  options = {};

  config = {
    virtualisation.forwardPorts = [
      { from = "host"; host.port = 4242; guest.port = 4242; }
      { from = "host"; host.port = 4002; guest.port = 4000;}
      { from = "host"; host.port = 4003; guest.port = 443;}
    ];

    users.users.your-main-user.password = "password";
  };
}