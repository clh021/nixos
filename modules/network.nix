{ ... }:

{
  networking.hostName = "chenlianghong-nixos"; # Define your hostname.
 
  # Enables wireless support via wpa_supplica>
  # networking.wireless.enable = true; 
 
  networking.networkmanager.enable = true;
 
  # use nmcil/nmtui to manager network 
  # programs.nm-applet.enable = true;


  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.allProxy = "http://127.0.0.1:8889";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Open ports in the firewall.
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 80 3389 8000 8080];
  networking.firewall.allowedUDPPorts = [ 5353 ];
  networking.firewall.allowPing = false;
  networking.firewall.rejectPackets = true;

  networking.extraHosts =
  ''
    172.17.0.3 gateway.netlier.cn
  '';
}
