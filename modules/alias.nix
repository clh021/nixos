{ config, ...}:

{
  environment.shellAliases = {
    rm = "trash";

    man_cn = "man -M /usr/share/man/zh_CN";
    man_tw = "man -M /usr/share/man/zh_TW";
    lt = "ls --human-readable --size -1 -S --classify";
    cpv = "rsync -ah --info=process2";

    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
    "....." = "cd ../../../..";
    pg = "cd $HOME/Programs";
    pj = "cd $HOME/Projects";

    c = "clear";
    r = "ranger";
    ems = "emacs -nw";
    
    nix-zsh = "nix-shell --run zsh";
    buildos = "sudo nixos-rebuild switch";
  };
}
