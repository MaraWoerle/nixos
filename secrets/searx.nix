{ pkgs, config, agenix, ... }:

{
  age.secrets = {
    networks = {
      file = ./searx.age;
      path = "/run/secrets/searx.env";
      owner = "mara";
      group = "users";
    };
  };
}
