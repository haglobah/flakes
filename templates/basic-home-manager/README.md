# basic-home-manager

An opinionated but basic home-manager setup flake.

# Setup

In addition to the [top-level README](../../README.md), to get up and running, you need to: 

1. Replace every occurrence of `"your-username"` with the host name of your system (once in `flake.nix`, twice in `home.nix`).
2. Insert your proper email address and full name (or whatever you want to write there) in `programs.git`.
3. Then, to instantiate your new home-manager configuration, run:
```bash
$ nix shell nixpkgs#home-manager
$ home-manager switch --flake .
```

Aand that should be it. Enjoy!