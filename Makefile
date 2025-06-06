.PHONY: mac
mac:
	nix build .#darwinConfigurations.scotts-MacBook-Pro.system
	sudo ./result/sw/bin/darwin-rebuild switch --flake . --show-trace -v || true

.PHONY: mac-arm64
mac-arm64:
	sudo nix build .#darwinConfigurations.scotts-MacBook-Air.system
	sudo ./result/sw/bin/darwin-rebuild switch --flake . --show-trace -v || true

.PHONY: update
update:
	sudo nix-channel --update
	sudo nix flake update

.PHONY: nixos
nixos:
	NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1 nix build .#nixosConfigurations.nixos.config.system.build.toplevel --impure
	sudo ./result/bin/switch-to-configuration switch 
