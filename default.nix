{ nixpkgs ? import <nixpkgs> {},
  compiler ? "ghc884" }:
let
  gitignore = nixpkgs.nix-gitignore.gitignoreSourcePure [ ./.gitignore ];
  myHaskellPackages = nixpkgs.pkgs.haskell.packages.${compiler}.override {
    overrides = self: super: rec {
      digits = self.callCabal2nixWithOptions "digits" (builtins.fetchGit {
        url = "http://hdiff.luite.com/cgit/digits/";
        rev = "65c0fa6315608f911666f5252026c25ece09938d";
      }) "--no-check" {};
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
    withHoogle = true;
  };
  exe = nixpkgs.haskell.lib.justStaticExecutables (myHaskellPackages.fourletters);
in
{
  inherit shell;
  inherit exe;
  inherit myHaskellPackages;
  fourletters = myHaskellPackages.fourletters;
}