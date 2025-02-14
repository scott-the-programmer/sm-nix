.PHONY: personal-mac
personal-mac:
	nix build .#darwinConfigurations.scotts-MacBook-Pro.system
	./result/sw/bin/darwin-rebuild switch --flake . --show-trace -v || true

.PHONY: personal-nixos
personal-nixos:
	nix build .#nixosConfigurations.nixos.config.system.build.toplevel
	sudo ./result/bin/switch-to-configuration switch
