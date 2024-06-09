{ config, pkgs, ... }:
  let 
    observe = pkgs.writeScriptBin "observe" ''
      if [[ -z $1 ]]; then
        echo "observe shows the status of running systemd services. The relevant ones on this machine are:
          observe nixos-upgrade
          observe build-colab"
      else
      journalctl --output cat --unit $1 --follow
      fi
    '';
  in
{
  imports = [
    ./pkgs.nix
    ./hardware-configuration.nix
  ];
  # Have a postgres instance running:
  # https://nixos.org/manual/nixos/stable/index.html#opt-services.postgresql.enable
  config = {
    environment = {
      systemPackages = with pkgs; [
        git
        observe
      ] ++ config.self-packages;
      variables = {
      };
      shellAliases = {
        "o" = "observe";
        "on" = "observe nixos-upgrade";

        "s" = "systemctl";
        "slt" = "systemctl list-timers";
        "st" = "systemctl status";
      };
    };

    age = {
      secrets = {
        secret-key-base = {
          file = "/home/your-main-user/colab/secrets/secret-key-base.age";
          owner = config.users.users.your-main-user.name;
          mode = "0444";
        };
      };

      identityPaths = [ "/home/your-main-user/.ssh/id_rsa" ];
    };

    networking = {
      firewall.allowedTCPPorts = [ 4000 443 80 ];
      hostName = "your-system-name";
      domain = "contaboserver.net";
    };

    system.autoUpgrade = {
      enable = true;
      flake = "git+ssh://git@github.com/haglobah/your-project-name.git#your-system-name";
      dates = "minutely";
      flags = [ "--accept-flake-config" "--option" "tarball-ttl" "0" ];
    };

    nix.settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = ["root" "your-main-user"];

      substituters = [
        "https://cache.nixos.org/"
        "https://cache.garnix.io"
      ];
      trusted-public-keys = [
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      ];
    };

    nixpkgs.config.allowUnfree = true;

    boot.tmp.cleanOnBoot = true;
    zramSwap.enable = true;
    services.openssh = {
      enable = true;
      ports = [ 4242 ];
      knownHosts = {
        github = {
          hostNames = [ "github.com" "*.github.com" ];
          publicKey = ''
            ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCj7ndNxQowgcQnjshcLrqPEiiphnt+VTTvDP6mHBL9j1aNUkY4Ue1gvwnGLVlOhGeYrnZaMgRK6+PKCUXaDbC7qtbW8gIkhL7aGCsOr/C56SJMy/BCZfxd1nWzAOxSDPgVsmerOBYfNqltV9/hWCqBywINIR+5dIg6JTJ72pcEpEjcYgXkE2YEFXV1JHnsKgbLWNlhScqb2UmyRkQyytRLtL+38TGxkxCflmO+5Z8CSSNY7GidjMIZ7Q4zMjA2n1nGrlTDkzwDCsw+wqFPGQA179cnfGWOWRVruj16z6XyvxvjJwbz0wQZ75XK5tKSb7FNyeIEs4TT4jk+S4dhPeAUC5y+bDYirYgM4GC7uEnztnZyaVWQ7B381AK4Qdrwt51ZqExKbQpTUNn+EjqoTwvqNj4kqx5QUCI0ThS/YkOxJCXmPUWZbhjpCg56i+2aB6CmK2JGhn57K5mj0MNdBXA4/WnwH6XoPWJzK5Nyu2zB3nAZp+S5hpQs+p1vN1/wsjk=
          '';
        };
      };
    };

    users.users = {
      root.openssh.authorizedKeys.keys = [''ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDXmmWIeLhoQMNXK9Q8qybmeBH7m9HULzARfp3C+RrbRuDcJORGMF3iT0K+zPnfAeruRBSyLN6EbruW51JihUN+NeHD3KpFfGI2BErjSOB0mvhKEUjvQDRwO9fHcYIiL9vsiLt3umyQmnJPhKipixEWIWbMiZeSLYwDpHP2smVItcxszeNPXc3iN977xi/SnkKW+njyl38oM8Oc9TAUBLvfxdPBhlB0rEELN74ySxoY5sFx7bTbQkEjOttM6WWWhrZZnC1vua9c/Da3uZg8H0QKYR2vR2JH0hbWbmH1jovBzZP2wVFkI/2zGx1cf+9AsMKG1LQgNRInPF+DT7Ul4mTdHwN1Fq6IEfPNoqeCqt4vcgVRQgW4kdfVoIXBAFjsISYcVyRCQCCimPf2I1vOJsWDGnus58suD0fL5pdJEm7LjfF6DL202gbJ7dKPTXp0HsFp4F8OHM0ppyjDySEtFpizf2b1jmu5x+///17DZls+L4m2dYxZML6prRN94YeBWbc= beat@nixos''
      ''ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCRG8q4HRFY2ZRSNid323FbRO9U3hLnxqUpF7kBBB/P9xy4Lwqs2wY5UwMqu9GPZwhapAXGFnvoZPvfVyi/5DWAfK6nwq5fon/1nU7denm8mqBdi9JQ7qjDjLaOdIwMQtoazwAh+XaNt49dYldegThqolKxOmQ871aznYPE1pY7b2EiGyRtPYI4ZsBr8WbvI+eX0uFfyIe8MnKekGj6FkE8Sg6z1Dsit1eEbpCbsVESSLNBXq+TvW29np8riWiqYb+9i2zam+AaXMQzbDn/Q7EFbmp/c8327RRjeJ2tId8/CZdjBc6oyD/VkWnFskdi+lfzh9w/Uce9Ykws6NQuJxCHFs+hvwNRb/OqT2+VIJDivmdnL8M9wg7Dmq7BPoV3qdliUT/Hfi8hHbTeTAfv4QMnd39ap+rM8/rq7dt+d3sa/1wSHzBQPfaRBP5Ie8+DjSEmsDzLml1wxGMnhX72kI3VWFWRsXmfS3krbDm3R/6hfdGGgxEboO4uUHKO1MU6SGM= beat@numenor'' ];
      
      your-main-user = {
        isNormalUser  = true;
        home  = "/home/your-main-user";
        description  = "The one to lead the flock with the flake";
        extraGroups  = [ "wheel" "networkmanager" ];
        openssh.authorizedKeys.keys  = [ ''ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDXmmWIeLhoQMNXK9Q8qybmeBH7m9HULzARfp3C+RrbRuDcJORGMF3iT0K+zPnfAeruRBSyLN6EbruW51JihUN+NeHD3KpFfGI2BErjSOB0mvhKEUjvQDRwO9fHcYIiL9vsiLt3umyQmnJPhKipixEWIWbMiZeSLYwDpHP2smVItcxszeNPXc3iN977xi/SnkKW+njyl38oM8Oc9TAUBLvfxdPBhlB0rEELN74ySxoY5sFx7bTbQkEjOttM6WWWhrZZnC1vua9c/Da3uZg8H0QKYR2vR2JH0hbWbmH1jovBzZP2wVFkI/2zGx1cf+9AsMKG1LQgNRInPF+DT7Ul4mTdHwN1Fq6IEfPNoqeCqt4vcgVRQgW4kdfVoIXBAFjsISYcVyRCQCCimPf2I1vOJsWDGnus58suD0fL5pdJEm7LjfF6DL202gbJ7dKPTXp0HsFp4F8OHM0ppyjDySEtFpizf2b1jmu5x+///17DZls+L4m2dYxZML6prRN94YeBWbc= beat@nixos'' 
        ''ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCRG8q4HRFY2ZRSNid323FbRO9U3hLnxqUpF7kBBB/P9xy4Lwqs2wY5UwMqu9GPZwhapAXGFnvoZPvfVyi/5DWAfK6nwq5fon/1nU7denm8mqBdi9JQ7qjDjLaOdIwMQtoazwAh+XaNt49dYldegThqolKxOmQ871aznYPE1pY7b2EiGyRtPYI4ZsBr8WbvI+eX0uFfyIe8MnKekGj6FkE8Sg6z1Dsit1eEbpCbsVESSLNBXq+TvW29np8riWiqYb+9i2zam+AaXMQzbDn/Q7EFbmp/c8327RRjeJ2tId8/CZdjBc6oyD/VkWnFskdi+lfzh9w/Uce9Ykws6NQuJxCHFs+hvwNRb/OqT2+VIJDivmdnL8M9wg7Dmq7BPoV3qdliUT/Hfi8hHbTeTAfv4QMnd39ap+rM8/rq7dt+d3sa/1wSHzBQPfaRBP5Ie8+DjSEmsDzLml1wxGMnhX72kI3VWFWRsXmfS3krbDm3R/6hfdGGgxEboO4uUHKO1MU6SGM= beat@numenor'' ];
      };
    };

    system.stateVersion = "23.05";
  };
}
