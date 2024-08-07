# Kernel Development

## [Yocto Kernel Development](https://docs.yoctoproject.org/kernel-dev/index.html)

The Yocto Project provides a flexible set of tools and processes to help you create custom Linux-based systems for embedded products. Kernel development is a key aspect of this process, allowing you to customize the kernel to support your specific hardware requirements.

## Navigating MenuConfig

To start configuring the kernel using `menuconfig`, do not run `start-menuconfig.sh` from within Visual Studio Code (VSCode). Instead, open a new terminal window using `Ctrl+Alt+T` and execute the script.

```shell
./menuconfig.sh --kernel
```

### General MenuConfig Screen Navigation

Navigating the `menuconfig` screen involves using arrow keys, Enter, and Esc. Here are the basic steps for navigating to various device drivers:

1. **Network Devices Drivers**
   - Navigate to: `Device Drivers -> Network device support -> Ethernet driver support`
   - Navigate to: `Device Drivers -> Network device support -> USB driver support`
   - Navigate to: `Device Drivers -> Network device support -> Wireless LAN`

2. **USB Device Drivers**
   - Navigate to: `Device Drivers -> USB support`

3. **Dummy Network Interface (Optional for QEMU)**
   - Navigate to: `Device Drivers -> Network device support -> Network core driver support`

## [Login BMR to Assertain Hardware](factory-start.md#step-by-step-instructions)

### Steps for Identifying Hardware

1. **Identify Ethernet Hardware**
   - **Command**: `lspci | grep -i ethernet`
     - **Description**: Lists all PCI devices and filters for Ethernet controllers.
   - **Command**: `dmesg | grep -i ethernet`
     - **Description**: Displays the system message buffer and filters for Ethernet-related messages.

   ```shell
   lspci | grep -i ethernet
   dmesg | grep -i ethernet
   ```

2. **Identify Wireless Hardware**
   - **Command**: `lspci | grep -i wireless`
     - **Description**: Lists all PCI devices and filters for Wireless controllers.
   - **Command**: `dmesg | grep -i wireless`
     - **Description**: Displays the system message buffer and filters for Wireless-related messages.

   ```shell
   lspci | grep -i wireless
   dmesg | grep -i wireless
   ```

3. **Identify USB Hardware**
   - **Command**: `lsusb`
     - **Description**: Lists all USB devices connected to the system.
   - **Command**: `dmesg | grep -i usb`
     - **Description**: Displays the system message buffer and filters for USB-related messages.

   ```shell
   lsusb
   dmesg | grep -i usb
   ```

### Additional Tips

- [**Save Configuration**](../../yocto-meta-layers/meta-bare-metal-router/recipes-kernel/linux/files/.config) : After making changes, make sure to save your new kernel configuration. You can save it to the default `.config` file or specify a different filename.
- **Build Kernel**: Once the configuration is saved, build the kernel using your build system (e.g., `bitbake` for Yocto). Make sure to deploy the new kernel to your target device.
- **Documentation**: Refer to the [Yocto Project Kernel Development Manual](https://docs.yoctoproject.org/kernel-dev/index.html) for detailed instructions and advanced configurations.

By following these steps, you can customize the kernel to support your specific hardware, ensuring optimal performance and compatibility for your embedded system.