{ config, lib, ... }:

let
  cfg = config.services.netboot;
in

with lib;

{
  options.services.netboot.enable = mkEnableOption "Enable the Netboot Service";

  config = mkIf cfg.enable {
    networking.firewall.allowedUDPPorts = [
      69
    ];

    virtualisation.oci-containers.containers = {
      netbootxyz = {
        autoStart = true;
        environment = {
          NGINX_PORT = "80";
          WEB_APP_PORT = "3000";
          TFTPD_OPTS = "--tftp-single-port";
        };
        image = "ghcr.io/netbootxyz/netbootxyz";
        ports = [
          "3000:3000"
          "69:69/udp"
        ];
        volumes = [
          "/netboot/config:/config"
          "/netboot/assets:/assets"
        ];
      };
    };
  };
}
