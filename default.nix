{ nixpkgs ? import <nixpkgs> {},
  compiler ? "ghc8102" }:
let
  gitignore = nixpkgs.nix-gitignore.gitignoreSourcePure [ ./.gitignore ];
  myHaskellPackages = nixpkgs.pkgs.haskell.packages.${compiler}.override {
    overrides = self: super: rec {
      fourletters = self.callCabal2nix "fourletters" (gitignore ./.) {};
      digits = nixpkgs.haskellPackages.digits.overrideDerivation (attrs: {
        broken = false;
        postPatch = ''
          sed -i 's/_ _ _ _ = .*/_ _ _ _ _ = pure ()/g' Setup.lhs
          sed -i 's/runTests = tests/testHook = tests/' Setup.lhs
        '';
      });
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