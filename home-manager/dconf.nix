{ config, pkgs, lib, osConfig, ... }:

{
  config = lib.mkIf (osConfig.i3.enable || ) {
  };
}
