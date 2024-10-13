{
  description = "My first flake";

  inputs = {
    nixpkgs = {
      url = "nixpkgs/nixos-24.05";
    };
  };
  # shorthand nixpkgs.url = "nixpkgs/nixos-24.05";

  outputs = { self, nixpkgs , ... }:
    let
      lib = nixpkgs.lib;
    in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./configuration.nix ];
    };
  };
}