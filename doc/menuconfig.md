# Menu Configuration

This script provides an easy way to configure various components in your Yocto build using menuconfig.

## [Linux Kernel](../doc/kernel.md)

The Linux kernel is the core component of the operating system, responsible for managing hardware resources, providing essential system services, and enabling communication between hardware and software. Configuring the kernel allows you to enable or disable specific features, device drivers, filesystems, and other options tailored to your target device's requirements.

Kernel configuration options include:
- Enabling/disabling support for specific hardware devices (e.g., network adapters, storage controllers).
- Selecting filesystem support (e.g., ext4, NTFS, FAT).
- Enabling features such as networking protocols, security modules, and power management.

To configure the Linux kernel options:

```bash
./menuconfig.sh --kernel
```

## BusyBox

BusyBox is a utility that combines many standard Unix utilities into a single executable, providing a lightweight and efficient way to perform common system tasks. It includes implementations of core utilities such as `sh`, `ls`, `grep`, `tar`, and many others. Configuring BusyBox allows you to select which utilities to include or exclude from the build, as well as customize their behavior and options.

BusyBox configuration options include:
- Selecting which applets to include in the BusyBox binary.
- Configuring applet behavior and options (e.g., command-line options, output formatting).
- Enabling features such as init system support, shell options, and networking utilities.

To configure BusyBox:

```bash
./menuconfig.sh --busybox
```

## UBoot

U-Boot (Unified Extensible Firmware Interface) is a widely used bootloader for embedded systems, responsible for initializing hardware, loading the Linux kernel into memory, and preparing the system for booting. Configuring U-Boot allows you to specify boot parameters, enable or disable features such as network support or USB booting, and customize settings specific to your target hardware.

U-Boot configuration options include:
- Setting boot parameters (e.g., kernel command line arguments, boot device).
- Enabling/disabling support for specific hardware features (e.g., USB, Ethernet).
- Configuring environment variables and boot scripts.

To configure U-Boot:

```bash
./menuconfig.sh --u-boot
```
