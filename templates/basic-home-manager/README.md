# basic-home-manager

An opinionated but basic home-manager setup flake.

Includes/Manages:
- git
- nix_direnv
- Starship
- zoxide (a better cd)
- eza (a better ls)
- a bunch of useful aliases
- wget & curl

# Setup

In addition to the [top-level README](../../README.md), to get up and running, you need to: 

1. Replace every occurrence of `your-username` with the host name of your system (once in `flake.nix`, twice in `home.nix`).
2. Insert your proper email address and full name (or whatever you want to write there) in `programs.git`. (If you already have a `.gitconfig` config you're happy with, skip this step.) 
3. Then, to instantiate your new home-manager configuration, run:
```bash
$ nix shell github:NixOS/nixpkgs/23.11#home-manager
$ home-manager switch --flake .
```
The last step may error:
1. Depending on the system/architecture you're using. If so, replace `system` in `flake.nix` with the `architecture-system`-tuple from the error message (the available ones being `x86_64-linux`,`aarch64-linux`, `aarch64-darwin`, `x86_64-darwin`)
2. Also, it might be that some already existing files are conflicting with files that Home Manager tries to create: For resolving that, run
```bash
$ home-manager switch -b backup --flake . 
```
That will backup all conflicting files in as `.backup` files, making it easy to restore the previous state.

Aand that should be it. Enjoy!