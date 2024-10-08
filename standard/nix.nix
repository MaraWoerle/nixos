{ pkgs, inputs, ... }:

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
  environment.systemPackages = [
    inputs.agenix.packages."${pkgs.system}".default
  ];
}
