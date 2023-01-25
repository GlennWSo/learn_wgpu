{
  inputs = {
    fenix.url = "github:nix-community/fenix";
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs, fenix }:

  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; }; 

  in {
    devShells.${system}.default = pkgs.mkShell rec {
      name = "cargo-zone";

      buildInputs = [
        pkgs.stdenv.cc.cc.lib
        pkgs.libglvnd
        pkgs.libGLU
        pkgs.fontconfig
        pkgs.xorg.libX11
        pkgs.xorg.libXi
        pkgs.xorg.libXrandr
        pkgs.xorg.libXrender
        pkgs.xorg.libXcursor
        pkgs.xorg.libXfixes
        pkgs.xorg.libXft
        pkgs.xorg.libXinerama
        pkgs.xorg.libXmu
        pkgs.zlib
        (fenix.packages.${system}.fromToolchainFile {
          file = ./rust-toolchain.toml;
          sha256 = "sha256-kI+vy5ThOmIdokk5Xtg1I7MyG1xzihcfI0T+hrAgsjA=";
        })
      ];
      
      LD_LIBRARY_PATH = "${pkgs.lib.strings.makeLibraryPath buildInputs}";
    };
  };
}
