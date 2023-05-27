{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.opengl.extraPackages = with pkgs; [
    pkgs.amdvlk
    rocm-opencl-icd
    rocm-opencl-runtime
];

  hardware.opengl.extraPackages32 = [
    pkgs.driversi686Linux.amdvlk
];

  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;

  environment.variables.AMD_VULKAN_ICD = "RADV";

  networking.hostName = "nixDesktop"; # Define your hostname.

  # Firewall- block all
  networking.firewall.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Prague";

  # Desktop Environment
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.displayManager.startx.enable = true;

  #programs.light.enable = true;
  virtualisation.libvirtd.enable = true;
  programs.adb.enable = true;

  # CoreCtrl
  programs.corectrl.enable = true;
  programs.corectrl.gpuOverclock.enable = true;
  programs.corectrl.gpuOverclock.ppfeaturemask = "0xffffffff";
 
  nix.gc = {
  automatic = true;
  dates = "weekly";
  options = "--delete-older-than 7d";
  };

  system.autoUpgrade = {
    enable = true;
    dates = "weekly";
    allowReboot = false;
  };

  services.power-profiles-daemon.enable = false;
  
  # PipeWire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };


  users.users.ondra = {
     isNormalUser = true;
     extraGroups = [ "wheel" "video" "libvirtd" "adbusers" ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
     vim
     wget
     firefox
     htop
     neofetch
     git
     lm_sensors
     virt-manager
     linuxKernel.packages.linux_6_3.cpupower
     vscodium
     kate
     dolphin
     libreoffice-fresh
     ark
     unzip
     nfs-utils
     discord
     microcodeIntel
     steam
     openrgb
   ];

  nixpkgs.config.allowUnfree = true;


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}

