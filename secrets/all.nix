{ pkgs, config, agenix, ... }:

{
  age.secrets = {
    networks = {
      file = ./networks.age;
      path = "/run/secrets/wireless.env";
      owner = "mara";
      group = "users";
    };
  };
}
