{ nixpkgs ? import <unstable> {},
  compiler ? "ghc901" }: # time-compat tests fail on 901
let
  gitignore = nixpkgs.nix-gitignore.gitignoreSourcePure [ ./.gitignore ];
  myHaskellPackages = nixpkgs.pkgs.haskell.packages.${compiler}.override {
    overrides = self: super: rec {
      digits = (self.callHackage "digits" "0.3.1" {}).overrideDerivation (self: {
        prePatch = ''
          echo -e "> import Distribution.Simple\n> main = defaultMain" > Setup.lhs
        '';
      });
      fourletters = self.callCabal2nix "fourletters" (gitignore ./.) {};
    };
  };
  shell = myHaskellPackages.shellFor {
    packages = p: [
      p.fourletters
    ];
    buildInputs = [
      nixpkgs.haskellPackages.cabal-install
      nixpkgs.wget
      nixpkgs.haskellPackages.stack
      nixpkgs.haskellPackages.ghcid
      nixpkgs.haskellPackages.stylish-haskell
      nixpkgs.haskellPackages.hlint
    ];
    withHoogle = false;
  };
  exe = nixpkgs.haskell.lib.justStaticExecutables (myHaskellPackages.fourletters);
in
{
  inherit shell;
  inherit exe;
  inherit myHaskellPackages;
  fourletters = myHaskellPackages.fourletters;
}
