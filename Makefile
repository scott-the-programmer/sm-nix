.PHONY: mac
mac:
	nix build .#darwinConfigurations.scotts-MacBook-Pro.system
	./result/sw/bin/darwin-rebuild switch --flake . --show-trace -v || true

.PHONY: nixos
nixos:
	nix build .#nixosConfigurations.nixos.config.system.build.toplevel --impure
	sudo ./result/bin/switch-to-configuration switch 
