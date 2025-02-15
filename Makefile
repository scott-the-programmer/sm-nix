.PHONY: mac
mac:
	nix build .#darwinConfigurations.scotts-MacBook-Pro.system
	./result/sw/bin/darwin-rebuild switch --flake . --show-trace -v || true

.PHONY: nixos
nixos:
	NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1 nix build .#nixosConfigurations.nixos.config.system.build.toplevel --impure
	sudo ./result/bin/switch-to-configuration switch 
