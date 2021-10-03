# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/alias.nix
#      ./modules/fcitx5
      ./modules/i18n.nix
      ./modules/users.nix
#      ./modules/vscodium.nix
      ./modules/zsh.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  # boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  # https://nixos.wiki/wiki/Dual_Booting_NixOS_and_Windows
  time.hardwareClockInLocalTime = true;

  # https://nixos.wiki/wiki/Accelerated_Video_Playback
  nixpkgs.config.packageOverrides = pkgs: { vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; }; };
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [ intel-media-driver vaapiIntel vaapiVdpau libvdpau-va-gl ];
    extraPackages32 = with pkgs.pkgsi686Linux; [ vaapiIntel ];
  };

  networking.hostName = "chenlianghong-nixos"; # Define your hostname.
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.wireless.interfaces = [ "wlp3s0" ];
  hardware.cpu.intel.updateMicrocode = true;
  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  #networking.useDHCP = true;
  #networking.interfaces.enp0s25.useDHCP = true;
  #networking.interfaces.wlp3s0.useDHCP = true;
  #networking.interfaces.wwp0s20u4.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Enable the Plasma 5 Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  # Enable bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = false;
  hardware.enableAllFirmware = true;


  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # List packages installed in system profile. To search, run:
  
  #programs.home-manager.enable = true;

  #home.sessionVariables = { NIXPKGS_ALLOW_UNFREE = 1; };
  nixpkgs.config.allowUnfree = true;

  # $ nix search wget
  environment.systemPackages = with pkgs; [
     # terminal tools
     strace # strace -f -F -o ~/exec.log execbin
     tcpdump # sudo tcpdump -X -i any port 7900
     vim tmux curl gitFull wget wmctrl bat iftop htop tree

     os-prober # 多系统自动添加引导

     # zsh     
     oh-my-zsh
     zsh-autosuggestions
     zsh-syntax-highlighting

     # KDE dolphin 右键压缩解压缩
     ark unrar lzop lrzip zip unzip p7zip

     # fonts
     wqy_zenhei
     wqy_microhei

     # application
     chromium
     vscodium
     flameshot
     pick-colour-picker 
     redshift
     fractal
     vlc
     tdesktop
     authy
     onlyoffice-bin
     docker docker-compose
     nodePackages.npm
     go go-tools protobuf
     #dbus-glib #lithium-gecko-engine 依赖
     virtualbox
     # 光盘刻录软件
     k3b cdrkit

     # other
     # 新一代多系统启动U盘解决方案 https://www.ventoy.net/cn/doc_disk_layout_gpt.html
     # https://github.com/ventoy/Ventoy/releases
     # ventoy-bin
     # 图形界面 sudo ventoyweb
  ];

  # 启动 docker 服务
  virtualisation.docker.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  services.sshd.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?
  nix.binaryCaches = [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" ];
}

