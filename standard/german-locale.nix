{ ... }:

{
  console = {
    keymap = "de";
  };
  i18n = {
    defaultLocale = "en_GB.UTF-8";
    supportedLocales = [
      "C.UTF-8/UTF-8"
      "en_GB.UTF-8/UTF-8"
      "de_DE.UTF-8/UTF-8"
    ];
    extraLocaleSettings = {
      LANGUAGE = "en_GB.UTF-8";
      LC_ALL = "de_DE.UTF-8";
      LC_ADDRESS = "de_DE.UTF-8";
      LC_IDENTIFICATION = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "de_DE.UTF-8";
      LC_NUMERIC = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
      LANG = "en_GB.UTF-8";
    };
  };
}
