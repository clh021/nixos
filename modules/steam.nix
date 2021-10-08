{pkgs, config, ...}:
{
  #nixpkgs.config.packageOverrides = pkgs: {
  #  steam = pkgs.steam.override {
  #    nativeOnly = true;
  #  };
  #};
  programs.steam.enable = true;
}

