{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "your-username";
  home.homeDirectory = "/home/your-username";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    wget
    curl

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/your-username/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userEmail = "you@example.com";
    userName = "John Doe";
    extraConfig = {
      core.sshCommand = "ssh -i ~/.ssh/id_rsa -F /dev/null";
      init.defaultBranch = "main";
      rerere.enabled = true;
      branch.sort = "-committerdate";
    };
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      ".." = "cd ..";
      "cp" = "cp -i";
      "h" = "history";
      "l" = "lla";
      "mv" = "mv -i";
      "rm" = "rm -i";
      "which" = "type -a";

      "grep" = "grep --color=auto";

      "gi" = "git init";
      "ga" = "git add";
      "gu" = "git restore --staged";
      "gs" = "git status -s -b";
      "gst" = "git status";
      "gbr" = "git branch -a -v";
      "gb" = "git for-each-ref --color --sort=-committerdate --format=$'%(color:green)%(ahead-behind:HEAD)\t%(color:blue)%(refname:short)\t%(color:yellow)%(committerdate:relative)\t%(color:default)%(describe)'     refs/ | sed 's/ /\t/' | column --separator=$'\t' --table --table-columns='Ahead,Behind,Branch Name,Last Commit,Description'";
      "gl" = "git log --oneline --decorate --graph";
      "gcm" = "git commit -m";
      "gam" = "git add . && git commit -m";
      "gp" = "git push";
      "gpf" = "git push --force-with-lease";
      "gpu" = "git push --set-upstream";
      "gpo" = "git push --set-upstream origin";
      "gf" = "git pull";
      "gF" = "git fetch";
      "gun" = "git rm --cached";
      "gcb" = "git checkout -b";
      "gsw" = "git switch";
      "gco" = "git checkout";
      "gme" = "git merge";
      "gra" = "git remote add";
      "gro" = "git remote add origin";
      "grv" = "git remote --verbose";
      "gca" = "git commit --amend";
      "gcan" = "git commit --amend --no-edit";
      "gacan" = "git add . && git commit --amend --no-edit";
      "gcl" = "git clone";
      "gd" = "git diff --word-diff";
      "gdl" = "git diff";
      "gsh" = "git stash";

      "nre" = "sudo nixos-rebuild switch --flake .";
      "nure" = "nix flake update && sudo nixos-rebuild switch --flake .";
      "nsh" = "nix shell";

      "nf" = "nix flake";
      "nfc" = "nix flake check";
      "nft" = "nix flake init --template";
      "nfs" = "nix flake show";
      "nfu" = "nix flake update";
      "nr" = "nix run . --";
      "nl" = "nix run -L . --";
      "nb" = "nix build";
      "nd" = "nix develop";

      "da" = "direnv allow";
      "dr" = "direnv reload";

      "c" = "code . &";
      
      "hm" = "home-manager";
      "hsw" = "home-manager switch --flake .";
      "reload" = ". ~/.bash_profile";
    };

    initExtra = ''
      md () {
        mkdir -p -- "$1" && cd -P -- "$1"
      } 

      freq () {
        history | cut -c8- | cut -d" " --fields=1"$1" | sort | uniq -c | sort -rn
      }

      gap () {
        git add . && git commit --message="$1" && git push 
      }
      gm () {
        git add "''${@:2}" && git commit --message="$1"
      }

      # export PATH="$PATH:~/.config/emacs/bin"
      # export PATH="$PATH:~/.emacs.d/bin"
      # export EDITOR="emacs"
    '';
  };

  programs.direnv = {
      enable = true;
      enableBashIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };

  # programs.vscode = {
  #   enable = true;
  #   userSettings = {
  #     "workbench.colorTheme" = "Palenight (Mild Contrast)";
  #     "editor.fontFamily" = "'FiraCode Nerd Font', 'DroidSansMono', monospace";
  #     "editor.fontLigatures" = true;
  #     "editor.minimap.enabled" = false;
  #     "editor.glyphMargin" = false;
  #     "editor.folding" = false;
  #     "editor.wordWrap" = "bounded";
  #     "editor.wordWrapColumn" = 160;
  #     "editor.scrollbar.verticalScrollbarSize" = 3;
  #     "editor.scrollbar.horizontalScrollbarSize" = 3;
  #     "editor.bracketPairColorization.enabled" = true;
  #     "workbench.colorCustomizations" = {
  #       "editorBracketHighlight.foreground1" = "#5caeef";
  #       "editorBracketHighlight.foreground2" = "#dfb976";
  #       "editorBracketHighlight.foreground3" = "#c172d9";
  #       "editorBracketHighlight.foreground4" = "#4fb1bc";
  #       "editorBracketHighlight.foreground5" = "#97c26c";
  #       "editorBracketHighlight.foreground6" = "#abb2c0";
  #       "editorBracketHighlight.unexpectedBracket.foreground" = "#db6165";
  #     };
  #     "files.autoSave" = "onFocusChange";
  #     "editor.tabSize" = 2;
  #     "direnv.restart.automatic" = true;
  #     "terminal.integrated.enableMultiLinePasteWarning" = false;
  #     "explorer.confirmDelete" = false;
  #     "window.zoomLevel" = -1;
  #     "files.associations" = {
  #       "*.glsl" = "c";
  #     };
  #   };
  #   keybindings = [
  #     {
  #         "key" = "shift+alt+down";
  #         "command" = "editor.action.copyLinesDownAction";
  #         "when" = "editorTextFocus && !editorReadonly";
  #     }
  #     {
  #         "key" = "ctrl+shift+alt+down";
  #         "command" = "-editor.action.copyLinesDownAction";
  #         "when" = "editorTextFocus && !editorReadonly";
  #     }
  #     {
  #         "key" = "shift+alt+up";
  #         "command" = "editor.action.copyLinesUpAction";
  #         "when" = "editorTextFocus && !editorReadonly";
  #     }
  #     {
  #         "key" = "ctrl+shift+alt+up";
  #         "command" = "-editor.action.copyLinesUpAction";
  #         "when" = "editorTextFocus && !editorReadonly";
  #     }
  #     {
  #         "key" = "shift+alt+up";
  #         "command" = "-editor.action.insertCursorAbove";
  #         "when" = "editorTextFocus";
  #     }
  #     {
  #         "key" = "shift+alt+down";
  #         "command" = "-editor.action.insertCursorBelow";
  #         "when" = "editorTextFocus";
  #     }
  #     {
  #       "key" = "ctrl+shift+t";
  #       "command" = "workbench.action.terminal.split";
  #       "when" = "terminalFocus && terminalProcessSupported || terminalFocus && terminalWebExtensionContributedProfile";
  #     }
  #     {
  #       "key" = "ctrl+shift+5";
  #       "command" = "-workbench.action.terminal.split";
  #       "when" = "terminalFocus && terminalProcessSupported || terminalFocus && terminalWebExtensionContributedProfile";
  #     }
  #   ];
  # };

  programs.starship = {
    enable = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      add_newline = false;

      format = builtins.concatStringsSep "" [
        "$line_break"
        "$all"
      ];

      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };

      battery = {
        display = [
          {threshold = 30; style = "bold red";}
        ];
      };

      # package.disabled = true;
    };
  };

  programs.eza = {
    enable = true;
    enableBashIntegration = true;
    git = true;
  };
  programs.zoxide = {
    enable = true;
  };
  programs.fzf = {
    enable = true;
  };
}
