# My Nix Configuration

Minimal dev configuration for my machines cobbled together with Claude

You probably don't want to run this directly, but rather use it as a reference for your own configuration.

## Installation

```console
nix build .#darwinConfigurations.Scotts-MacBook-Pro-9.system
./result/sw/bin/darwin-rebuild switch --flake . 
```
