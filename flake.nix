{

 description = "My first flake!";

 inputs = {
  #nixpkgs = {
  #  url = "github:NixOS/nixpkgs/nixos-24.05";
  #};
  nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  home-manager.url = "github:nix-community/home-manager/release-24.05";
  home-manager.inputs.nixpkgs.follows = "nixpkgs";
 };

 outputs = { self, nixpkgs, home-manager ,...}@inputs :
 { 
 nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    ./configuration.nix
    home-manager.nixosModules.home-manager {
      home-manager.backupFileExtension = "hm-backup";
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.nazara = import ./home.nix;
     }
    ];
   };
  };

}
 
