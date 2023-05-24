{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = ["amd_pstate=passive"];

  hardware.opengl.extraPackages = [
	pkgs.amdvlk
    rocm-opencl-icd
	];

  hardware.opengl.extraPackages32 = [
	pkgs.driversi686Linux.amdvlk
	];

  hardware.opengl.driSupport = true;
  environment.variables.AMD_VULKAN_ICD = "RADV";

#   powerManagement.cpuFreqGovernor = "conservative";

  networking.hostName = "nixLaptop"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  #networking.wireless.userControlled.enable = true;

  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.


  # Set your time zone.
  time.timeZone = "Europe/Prague";

  programs.light.enable = true;
  virtualisation.libvirtd.enable = true;
  programs.adb.enable = true;
 
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

   
  services.tlp = {
    enable = true;
    settings = {
	CPU_SCALING_GOVERNOR_ON_AC = "schedutil";
	CPU_SCALING_GOVERNOR_ON_BAT= "conservative";
	CPU_BOOST_ON_AC = 1;
	CPU_BOOST_ON_BAT = 0;
	SCHED_POWERSAVE_ON_AC = 0;
	SCHED_POWERSAVE_ON_BAT = 1;
	NMI_WATCHDOG = 0;
	PLATFORM_PROFILE_ON_AC = "balanced";
	PLATFORM_PROFILE_ON_BAT = "low-power";
	AHCI_RUNTIME_PM_ON_AC = "on";
	AHCI_RUNTIME_PM_ON_BAT = "auto";
	RADEON_DPM_PERF_LEVEL_ON_AC = "auto";
	RADEON_DPM_PERF_LEVEL_ON_BAT = "auto";
	RADEON_DPM_STATE_ON_AC = "balanced";
	RADEON_DPM_STATE_ON_BAT = "battery";
	RADEON_POWER_PROFILE_ON_AC = "auto";
	RADEON_POWER_PROFILE_ON_BAT = "auto";
	WIFI_PWR_ON_AC = "off";
	WIFI_PWR_ON_BAT = "on";
	PCIE_ASPM_ON_AC = "default";
	PCIE_ASPM_ON_BAT = "powersupersave";
	USB_EXCLUDE_PHONE = 1;
    };
  };

#   security.sudo.extraRules= [
#   {  users = [ "ondra" ];
#     commands = [
#        { command = "/nix/store/nzxnkhmxj766f9jq3m3sjndw1fpzi16j-ryzenadj-0.11.1/bin/ryzenadj" ; options= [ "NOPASSWD" ];}
#        { command = "/home/ondra/.config/sway/rootScripts/napajeniKontrola.sh" ;}
#     ];
#   }
# ];


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
     extraGroups = [ "wheel" "video" "networkmanager" "libvirtd" "adbusers" ];
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
     pulseaudio
     virt-manager
#      linuxKernel.packages.linux_6_2.cpupower
     vscodium
   ];


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}

