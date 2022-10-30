{
  description = "A simple Go CLI template";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      rec {
        devShells = {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              git

              go-task

              go
              golangci-lint
            ];

            shellHook = ''
              ${pkgs.go}/bin/go version
            '';
          };

          ci = devShells.default;
        };
      });
}
