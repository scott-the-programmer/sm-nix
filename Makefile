.PHONY: personal-mac
personal-mac:
	nix build .#darwinConfigurations.Scotts-MacBook-Pro-9.system
	./result/sw/bin/darwin-rebuild switch --flake . --show-trace -v || true
