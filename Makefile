.PHONY: personal-mac
personal-mac:
	nix build .#darwinConfigurations.scotts-MacBook-Pro.system
	./result/sw/bin/darwin-rebuild switch --flake . --show-trace -v --ask-sudo-password || true
