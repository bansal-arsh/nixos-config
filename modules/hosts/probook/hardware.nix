{inputs, ...}: let
  hostname = "probook";
in {
  # TODO: Remove after linux-firmware is fixed
  flake-file.inputs = {
    linux-firmware-old = {
      url = "gitlab:kernel-firmware/linux-firmware/20260810";
      flake = false;
    };
  };

  flake.modules.nixos.${hostname} = {
    config,
    lib,
    pkgs,
    modulesPath,
    ...
  }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "usb_storage" "sd_mod"];
    boot.initrd.kernelModules = [];
    boot.kernelModules = ["kvm-amd"];
    boot.extraModulePackages = [];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/309d0bca-28cb-4d31-beb0-52b953957b42";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/3F1E-3FE7";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };

    swapDevices = [
      {
        device = "/var/lib/.swapfile";
        size = 16 * 1024;
      }
    ];

    # TODO: Remove after linux-firmware is fixed
    hardware.firmware = lib.mkBefore [
      (pkgs.runCommand "amdgpu-fw-20260810" {} ''
        mkdir -p $out/lib/firmware
        cp -r ${inputs.linux-firmware-old}/amdgpu $out/lib/firmware/
      '')
    ];

    boot.kernelParams = ["resume_offset=107888640" "mem_sleep_default=deep" "amdgpu.dcdebugmask=0x40000"];
    boot.resumeDevice = "/dev/disk/by-uuid/309d0bca-28cb-4d31-beb0-52b953957b42";
    powerManagement.enable = true;

    services.power-profiles-daemon.enable = true;
    services.logind.settings.Login = {
      # Suspend first then hibernate when closing the lid
      LidSwitch = "suspend-then-hibernate";
      # Hibernate on power button pressed
      PowerKey = "hibernate";
      PowerKeyLongPress = "poweroff";
    };

    # Define time delay for hibernation
    systemd.sleep.settings.Sleep = {
      HibernateDelaySec = "30m";
      SuspendState = "mem";
    };

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
