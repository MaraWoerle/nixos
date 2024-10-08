{ config, lib, ... }:

{
  config = lib.mkIf config.services.openssh.enable {
    services.openssh = {
      allowSFTP = true;
      openFirewall = true;
      # require public key authentication for better security
      settings.PasswordAuthentication = true;
      settings.KbdInteractiveAuthentication = false;
      #settings.PermitRootLogin = "yes";
    };
  };
}
