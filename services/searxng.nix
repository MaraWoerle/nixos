{ config, lib, pkgs, ... }:

let
  cfg = config.services.epz-search;
in

with lib;

{
  options = {
    services.epz-search = {
      enable = mkEnableOption "Enable the EPZ Search";

      design-files = mkOption {
        type = with types; path;
        description = ''
          Directory to the Design files;
        '';
      };

      name = mkOption {
        type = with types; uniq str;
        description = ''
          Name of the Instance
        '';
      };

      address = mkOption {
        default = "0.0.0.0";
        type = with types; uniq str;
        description = ''
          Bind Address
        '';
      };

      port = mkOption {
        default = 8080;
        type = with types; int;
        description = ''
          Port to use
        '';
      };

      key = mkOption {
        type = with types; uniq str;
        description = ''
          A secret key for the instance
        '';
      };

      envFile = mkOption {
        type = with types; nullOr str;
        default = null;
        description = ''
          An environment file
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    services.searx = {
      enable = true;
      environmentFile = cfg.envFile;
      package = pkgs.searxng.overrideAttrs (old: {
        postInstall = old.postInstall + ''
          cp ${cfg.design-files}/img/favicon.png $out/lib/python3.11/site-packages/searx/static/themes/simple/img/favicon.png
          cp ${cfg.design-files}/img/favicon.svg $out/lib/python3.11/site-packages/searx/static/themes/simple/img/favicon.svg
          cp ${cfg.design-files}/img/img_load_error.svg $out/lib/python3.11/site-packages/searx/static/themes/simple/img/img_load_error.svg
          cp ${cfg.design-files}/img/searxng.png $out/lib/python3.11/site-packages/searx/static/themes/simple/img/searxng.png
          cp ${cfg.design-files}/img/searxng.svg $out/lib/python3.11/site-packages/searx/static/themes/simple/img/searxng.svg
        '';
      });
      settings = {
        general = {
          instance_name = cfg.name;
        };
        search = {
          autocomplete = "duckduckgo";
        };
        server = {
          port = cfg.port;
          bind_address = cfg.address;
          secret_key = cfg.key;
        };
        ui = {
          center_alignment = true;
          infinite_scroll = true;
          query_in_title = true;
        };
        engines = lib.mapAttrsToList (name: value: {inherit name;} // value) {
          "deviantart".disabled = true;
        };
      };
    };


    networking.firewall.allowedTCPPorts =
    [
      cfg.port
    ];
  };
}
