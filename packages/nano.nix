{ ... }:

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
      bind ^c copy main
      bind ^x cut main
      bind ^v paste main
      bind ^z undo main
      bind ^y redo main
      bind ^f whereis main
      bind ^h replace main
      bind ^q exit main
    '';
  };
}
