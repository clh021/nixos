{ config, pkgs, ... }:

{
  services.xserver.desktopManager.xfce.enable = true;
  # services.xserver.desktopManager.gnome3.enable = true;
  services.xserver.desktopManager.mate.enable = true;
  # services.xserver.windowManager.xmonad.enable = true;
  # services.xserver.windowManager.twm.enable = true;
  # services.xserver.windowManager.icewm.enable = true;
  # services.xserver.windowManager.i3.enable = true;

  users.users.mate = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "libvirtd" "vboxusers" "docker" "audio" "sound" "video" "input" "tty" "camera"];
  };
  users.users.xfce = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "libvirtd" "vboxusers" "docker" "audio" "sound" "video" "input" "tty" "camera"];
  };

  security.sudo.extraRules = [
    {
      users = [ "mate" "xfce" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

}