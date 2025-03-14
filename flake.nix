{
  description = "vo1ded-panel rewritten in Rust and Qt";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    rust-toolchain = pkgs.symlinkJoin {
      name = "rust-toolchain-full";
      paths = with pkgs; [
        rustfmt
        rustc
        cargo
        cargo-watch
        rustPlatform.rustcSrc
        clippy
      ];
    };
  in {
    devShells.${system} = {
      default = pkgs.mkShell {
        buildInputs = [
          rust-toolchain
        ];
      };
    };
  };
}