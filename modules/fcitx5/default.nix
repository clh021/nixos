{ pkgs, home, ... }:
let
  zhwiki = (pkgs.callPackage ./zhwiki.nix) { };
  moegirl = (pkgs.callPackage ./moegirl.nix) { };
  fcitx5-nord = (pkgs.callPackage ./fcitx5-nord.nix) { };
  fcitx5_dicts = (pkgs.callPackage ./fcitx5_dicts.nix) { };
in
{
  # https://github.com/felixonmars/fcitx5-pinyin-zhwiki
  # https://nixos.wiki/wiki/Home_Manager
  home.file.".local/share/fcitx5/pinyin/dictionaries/${zhwiki.fileName}".source =
    "${zhwiki}/${zhwiki.fileName}";
  home.file.".local/share/fcitx5/pinyin/dictionaries/${moegirl.fileName}".source =
    "${moegirl}/${moegirl.fileName}";
  home.file.".local/share/fcitx5/themes/".source = "${fcitx5-nord}";
  home.file.".local/share/fcitx5/pinyin/dictionaries/${fcitx5_dicts.fileName}".source =
    "${fcitx5_dicts}/${fcitx5_dicts.fileName}";
}
