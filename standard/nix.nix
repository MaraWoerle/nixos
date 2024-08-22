{ ... }:

{
  nix = {
    # Optimisation
    optimise.automatic = true;
    settings.auto-optimise-store = true;
    # Experimental
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}