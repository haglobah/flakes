{ config, self', inputs', pkgs, system, ... }:
{
  imports = [
    ./pkgs.nix
  ];

  config = {
    packages = config.self-packages;

    commands = [

      { name = "ae"; command = ''nix run github:ryantm/agenix -- -e $1''; help = "Run agenix --edit-file"; }
      { name = "ad"; command = ''nix run github:ryantm/agenix -- -d $1''; help = "Run agenix --decrypt"; }
      { name = "p"; command = ''mix test && git push''; help = "test first, then push if no errors"; }

      {
        name = "vm";
        command = ''
          rebuild () {
            nix build .#nixosConfigurations.test-vm.config.system.build.vm
            rm -f your-system-name.qcow2
            gawk -i inplace "!/4242/" ~/.ssh/known_hosts # remove known-hosts line for the new vm (since its fingerprint has changed)
            ./result/bin/run-your-system-name-vm &
          }
          launch () {
            ./result/bin/run-your-system-name-vm &
          }
          "$@"
        '';
        help = ''
          Commands grouped around the vm testing environment:
                    vm rebuild      - Build the vm, delete its predecessors' state, and launch it
                    vm launch       - Start the vm
        '';
      }
      {
        name = "enter";
        command = ''
          echo "Please change these lines, and fill in the correct values"

          # if [[ $1 == vm ]]; then
          #   ssh -A -p 4242 "$2"@localhost
          # elif [[ $1 == prod ]]; then
          #   ssh -A -p 4242 "$2"@62.171.165.146
          # fi
        '';
        help = ''enter <prod/vm> <root/finwe>: Enters either the vm or the production server via ssh.'';
      }
      {
        name = "setup";
        command = ''
          echo "Please change these lines, and fill in the correct values"

          # if [[ $1 == vm ]]; then
          #   ssh -p 4242 finwe@localhost "mkdir -p ~/.ssh"
          #   scp -P 4242 ~/.ssh/id_rsa finwe@localhost:~/.ssh/id_rsa
          #   scp -P 4242 ~/.ssh/id_rsa.pub finwe@localhost:~/.ssh/id_rsa.pub
          #   ssh -p 4242 finwe@localhost "git clone git@github.com:haglobah/colab.git"
          #   ssh -p 4242 root@localhost "reboot"
          # elif [[ $1 == prod ]]; then
          #   ssh -p 4242 finwe@62.171.165.146 "mkdir -p ~/.ssh"
          #   scp -P 4242 ~/.ssh/id_rsa finwe@62.171.165.146:~/.ssh/id_rsa
          #   scp -P 4242 ~/.ssh/id_rsa.pub finwe@62.171.165.146:~/.ssh/id_rsa.pub

          #   ssh -p 4242 root@62.171.165.146 "mkdir -p ~/.ssh"
          #   scp -P 4242 ~/.ssh/id_rsa root@62.171.165.146:~/.ssh/id_rsa
          #   scp -P 4242 ~/.ssh/id_rsa.pub root@62.171.165.146:~/.ssh/id_rsa.pub
            
          #   ssh -p 4242 finwe@62.171.165.146 "git clone git@github.com:haglobah/colab.git"
          #   ssh -p 4242 root@62.171.165.146 "reboot"
          # fi
        '';
        help = ''Setups either the vm or the production server with the necessary secrets.'';
        }
    ];
  };
}
