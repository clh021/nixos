{ config, ...}:

{
  environment.shellAliases = {
    rm = "rmtrash";

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
    os-rebuild = "echo nixos-rebuild switch;sudo nixos-rebuild switch";
    os-update = "echo nixos-rebuild switch --upgrade;sudo nixos-rebuild switch --upgrade";
    os-upgrade = "echo https://github.com/nixos-cn/NixOS-FAQ/blob/main/answers/how-to-upgrade-nixos-version.md;";
    # os-clean = "sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations +15;nix-env --delete-generations +5;"; # 下面的 gc 配置会自动清理
    # os-rollback = ""; # 系统降级
  };

  # nix-collect-garbage --delete-older-than 15d
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 15d";
    dates = "Sun 19:00";
  };
}
