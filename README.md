# flakes – a collection of Nix flake templates

As it might have been apparent from the name: To use this repository, you need to have [Nix](https://nixos.org) installed, with [flakes](https://zero-to-nix.com/concepts/flakes) enabled.

1. If you haven't done it already, [install Nix](https://zero-to-nix.com/start/install).
2. Have a look at all the templates available (or have a look [here](templates/)):
```
$ nix flake show github:haglobah/flakes
```
3. Then, clone a flake template that interests you:
```
$ nix flake init --template github:haglobah/flakes#TEMPLATE_NAME # exchange with 
```
4. Depending on the flake: Read their README, and finish the setup.

If you find anything that I might improve, or just have a question, please don't hesitate to open an issue or pull request :)