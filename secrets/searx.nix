{ pkgs, config, agenix, ... }:

{
  age.secrets = {
    searx = {
      file = ./searx.age;
      path = "/run/secrets/searx.env";
      owner = "mara";
      group = "users";
    };
  };
}
