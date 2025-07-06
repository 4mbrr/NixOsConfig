{
  description = "My flake :)";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    quickshell.url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
  };
  # shorthand nixpkgs.url = "nixpkgs/nixos-24.05";
  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      lib = nixpkgs.lib;
    in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [ 
      ./configuration.nix 
      home-manager.nixosModules.home-manager
      {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.amber = import ./home.nix;
            home-manager.backupFileExtension = "backup";

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
        }
      ];
    };
  };
}
