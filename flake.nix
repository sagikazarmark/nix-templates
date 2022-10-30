{
  description = "My Nix flake templates";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    {
      templates = {
        base = {
          path = ./base;
          description = "A basic project template";
        };
        base-dev = {
          path = ./base-dev;
          description = "A basic project template targeted at development";
          welcomeText = ''
            Choose a task runner for your project in flake.nix!

            Configure GitHub Actions according to your chosen task runner:

            ```shell
            # Given you chose go-task:
            mv .github/workflows/ci-task.yaml .github/workflows/ci.yaml
            rm .github/workflows/ci-make.yaml
            ```
          '';
        };
        go-simple-cli = {
          path = ./go-simple-cli;
          description = "A simple Go CLI template";
          welcomeText = ''
            Update your module path using the following command:

            ```shell
            go mod edit --module github.com/YOURNAME/YOURMODULE
            ```
          '';
        };
      };
    } // flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        update-envrc = pkgs.writeScriptBin "update-envrc" ''
          set -eo pipefail

          if [ -z $1 ]; then
            echo "no envrc version specified"
            exit 1
          fi

          VERSION=$1

          CHECKSUM=$(${pkgs.nix}/bin/nix hash to-sri --type sha256 $(${pkgs.nix}/bin/nix-prefetch-url https://raw.githubusercontent.com/nix-community/nix-direnv/$VERSION/direnvrc 2>/dev/null))

          for dir in `ls -d */`; do # Iterate through all the templates
            (
              cd $dir
              sed "s/nix_direnv_version [[:digit:]]\+\.[[:digit:]]\+\.[[:digit:]]\+/nix_direnv_version $VERSION/g; s|raw.githubusercontent.com/nix-community/nix-direnv/[[:digit:]]\+\.[[:digit:]]\+\.[[:digit:]]\+/direnvrc\" \".*\"|raw.githubusercontent.com/nix-community/nix-direnv/$VERSION/direnvrc\" \"$CHECKSUM\"|g" .envrc > .envrc.tmp
              mv .envrc.tmp .envrc
            )
          done
        '';
      in
      {
        devShells = {
          default = pkgs.mkShell {
            buildInputs = [ update-envrc ];
          };
        };
      });
}
