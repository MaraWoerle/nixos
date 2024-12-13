{ config, pkgs, lib, osConfig, ... }:

{
  config = lib.mkIf osConfig.gra-env.enable {
  };
}
