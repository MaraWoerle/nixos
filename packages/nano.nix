{ config, pkgs, ... }:

{
  programs.nano = {
    enable = true;
    nanorc = ''
      set tabstospaces
      set tabsize 2
      set autoindent
      set emptyline
      set linenumbers
      set trimblanks
      set zap
      set smarthome
    '';
  };
}
