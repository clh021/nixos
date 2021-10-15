{pkgs, config, ...}:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    # autosuggestions = {
    #   enable = true;
    #   strategy = "match_prev_cmd"; # one of "history", "match_prev_cmd"
    # };
  };
  # TODO  
  # https://discourse.nixos.org/t/installing-home-manager-from-nixos/8248
}
