{
  description = "My NixOS and macOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
    let
      homeManagerCommon = { username }: {
        home.username = username;
        home.stateVersion = "23.05"; 
        programs.bash.enable = true;
      };

      # macOS-specific configuration
      mkDarwinConfiguration = { system ? "x86_64-darwin", hostname, username }:
        nix-darwin.lib.darwinSystem {
          inherit system;
          modules = [
            ./darwin-configuration.nix
            home-manager.darwinModules.home-manager
            {
              system.configurationRevision = self.rev or self.dirtyRev or null;
              networking.hostName = hostname;
              home-manager.users.${username} = import ./home/darwin.nix;
              home-manager.extraSpecialArgs = { inherit username; };
              home-manager.backupFileExtension = "backup";
            }
          ];
          specialArgs = { inherit username; };
        };

      # NixOS-specific configuration
      mkNixosConfiguration = { system ? "x86_64-linux", hostname, username }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./nixos-configuration.nix
            home-manager.nixosModules.home-manager
            {
              system.configurationRevision = self.rev or self.dirtyRev or null;
              networking.hostName = hostname;
              home-manager.users.${username} = {
                imports = [ (homeManagerCommon { inherit username; }) ];
                home.homeDirectory = "/home/${username}"; # NixOS-specific
              };
              home-manager.users.${username} = import ./home/nixos.nix;
              home-manager.extraSpecialArgs = { inherit username; };
              home-manager.backupFileExtension = "backup";
            }
          ];
          specialArgs = { inherit username; };
        };
    in
    {
      darwinConfigurations."scotts-MacBook-Pro" = mkDarwinConfiguration {
        hostname = "scotts-MacBook-Pro";
        username = "scott";
      };

      nixosConfigurations."nixos" = mkNixosConfiguration {
        hostname = "nixos";
        username = "scott";
      };
    };
}
