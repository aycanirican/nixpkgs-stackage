# Generated by stackage2nix 0.7.2 from "/nix/store/6nhazjk3wgalhgrzicf1my2y4sk5311z-source/lts-12.14.yaml"
{ callPackage, buildPackages, pkgs, stdenv, lib
, overrides ? (self: super: {})
, packageSetConfig ? (self: super: {})
}:

let
  inherit (lib) extends makeExtensible;
  haskellLib = pkgs.haskell.lib;
  inherit (haskellLib) makePackageSet;
  
  haskellPackages = pkgs.callPackage makePackageSet {
                      ghc = buildPackages.haskell.compiler.ghc843;
                      buildHaskellPackages = buildPackages.haskell.packages.ghc843;
                      package-set = import ./packages.nix;
                      inherit stdenv haskellLib extensible-self;
                    };
  
  compilerConfig = import  ./configuration-packages.nix { inherit pkgs haskellLib; };
  
  configurationCommon = if builtins.pathExists ./configuration-common.nix then import ./configuration-common.nix { inherit pkgs haskellLib; } else self: super: {};
  configurationNix = import (pkgs.path + "/pkgs/development/haskell-modules/configuration-nix.nix") { inherit pkgs haskellLib; };
  
  extensible-self = makeExtensible (extends overrides (extends configurationCommon (extends packageSetConfig (extends compilerConfig (extends configurationNix haskellPackages)))));

in extensible-self
