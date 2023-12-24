{
  description = "software needed for collector";

  inputs = { 
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  };

  outputs = { self, nixpkgs }:
    let
      name = "dmchla";
      version = "0.0.0";
      forAllSystems = function:
        nixpkgs.lib.genAttrs [
          "x86_64-linux"
          "aarch64-linux"
        ] (system: function { pkgs = nixpkgs.legacyPackages.${system}; system = system; });
    in {
      devShells = forAllSystems ({ pkgs, system }: {
        default = pkgs.mkShell { 
          inherit name;
          buildInputs = with pkgs; [ nodejs_21 ];
        };
      });
    };
}
