{
  inputs = {
    fenix.url = "github:nix-community/fenix";
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs, fenix }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        name = "cargo-zone";
        buildInputs = [
          (fenix.packages.${system}.fromToolchainFile {
            file = ./rust-toolchain.toml;
            sha256 = "sha256-kI+vy5ThOmIdokk5Xtg1I7MyG1xzihcfI0T+hrAgsjA=";
          })
        ];
      };
    };
}
