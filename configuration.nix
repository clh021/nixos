# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/network.nix
      ./modules/virtualisation.nix
      ./modules/fonts.nix
      ./modules/alias.nix
      ./modules/i18n.nix
      ./modules/users.nix
      ./modules/zsh.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  #boot.loader.grub.version = 2;
  boot.loader.grub.efiSupport = true;
  #boot.loader.grub.efiInstallAsRemovable = true;
  # Define on which hard drive you want to install Grub.
  #boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only
  boot.loader.grub.device = "nodev"; # or "nodev" for efi only
  boot.loader.grub.useOSProber = true;

  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  

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

  hardware.cpu.intel.updateMicrocode = true;
  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Plasma 5 Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  
  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "startplasma-x11";

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;

  # Configuration of pulseaudio to facilitate bluetooth headphones and Steam.
  hardware.pulseaudio = {
    enable = true;
    # 32 bit support for steam.
    support32Bit = true;
    # NixOS allows either a lightweight build (default) or full build of PulseAudio to be installed.
    # Only the full build has Bluetooth support, so it must be selected here.
    package = pkgs.pulseaudioFull;
  };

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = false;
  hardware.enableAllFirmware = true;


  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # List packages installed in system profile. To search, run:
  
  #programs.home-manager.enable = true;

  # home.sessionVariables = { NIXPKGS_ALLOW_UNFREE = 1; };
  nixpkgs.config.allowUnfree = true;
  # environment.homeBinInPath = true; # 文档说 ~/bin 可用，可是没有生效

  # $ nix search wget
  environment.systemPackages = with pkgs; [
    home-manager
    direnv
    appimage-run
    steam-run
    # terminal tools
    strace # strace -f -F -o ~/exec.log execbin
    traceroute # 跟踪数据包通过 IP 网络所采用的路由
    tcpdump # sudo tcpdump -X -i any port 7900
    dig # domain info Groper
    # telnet inetutils # todo test
    ffmpeg
    xdotool #模拟击键和鼠标移动, 键盘精灵, xdotool 模拟用户交互
    tmux curl gitFull wget wmctrl bat iftop htop tree rmtrash
    vim # vimPlugins.ipython vimPlugins.vim-addon-syntax-checker vimPlugins.vim-addon-nix
    file jq iotop pstree ntfs3g 
    notify-desktop
    # zeal

    # KDE dolphin 右键压缩解压缩
    ark unrar lzop lrzip zip unzip p7zip

    # application
    chromium
    vscode
    flameshot
    pick-colour-picker 
    redshift
    fractal
    vlc
    remmina
    tdesktop
    # keepass
    keepassxc
    authy
    onlyoffice-bin
    docker docker-compose
    #dbus-glib #lithium-gecko-engine 依赖
    virtualboxWithExtpack
    #virtualboxExtpack
    # 光盘刻录软件
    # k3b cdrkit # 并不能刻录

    openssl

    # other
    # 新一代多系统启动U盘解决方案 https://www.ventoy.net/cn/doc_disk_layout_gpt.html
    # https://github.com/ventoy/Ventoy/releases
    # ventoy-bin
    # 图形界面 sudo ventoyweb
  ];

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?
  nix.binaryCaches = [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" ];
}

