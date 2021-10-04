{ pkgs,  ... }:

{
  # enable docker service
  virtualisation.docker.enable = true;
  
  # virtualbox
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "lee" ];
  # virtualbox exts (for use with usb)
  virtualisation.virtualbox.host.enableExtensionPack = true;
  virtualisation.virtualbox.host.enableHardening = false;

  # this is needed to get a bridge with DHCP enabled
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemuOvmf = true;

  # podman
  #virtualisation.podman.enable = true;
  #virtualisation.podman.dockerCompat = true;
}
