{

 description = "My first flake!";

 inputs = {
  #nixpkgs = {
  #  url = "github:NixOS/nixpkgs/nixos-24.05";
  #};
  nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  home-manager.url = "github:nix-community/home-manager/release-24.05";
  home-manager.inputs.nixpkgs.follows = "nixpkgs";
  nix-colors.url = "github:misterio77/nix-colors";
  stylix.url = "github:danth/stylix";
};

 outputs = { self, nixpkgs, home-manager, nix-colors, ...}@inputs :
 { 
 nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = {inherit inputs;};
  modules = [
    ./configuration.nix
    inputs.stylix.nixosModules.stylix
    home-manager.nixosModules.home-manager {
      home-manager.backupFileExtension = "hm-backup";
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.nazara = import ./home.nix;
      home-manager.extraSpecialArgs = { inherit nix-colors; };
     }
    ];
   };
  };

}
 
