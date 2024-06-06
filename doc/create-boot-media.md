# Methods of Loading BMROS onto Physical Media

## Types of Media Storage

BMROS can be installed onto various types of media storage. Here are the common types:

1. **USB Flash Drives**: 
   - Portable and easy to use.
   - Suitable for temporary installations or testing purposes.
   - Commonly used for live sessions or quick installations.
   - `/dev/sda`: Typically the first USB drive connected.
   - `/dev/sdb`, `/dev/sdc`, etc.: Subsequent USB drives connected will increment the letter (b, c, d, etc.).   

2. **Solid State Drives (SSDs)**:
   - Faster and more reliable than HDDs.
   - Ideal for permanent installations where speed is a priority.
   - Provide better performance and longevity.
   - `/dev/sda`: Commonly used for the primary SSD.
   - `/dev/sdb`, `/dev/sdc`, etc.: Additional SSDs connected to the system.

3. **SD Cards**:
   - Often used in embedded systems and single-board computers (e.g., Raspberry Pi).
   - Convenient for small, lightweight installations.
   - Limited in capacity compared to SSDs and HDDs but sufficient for many embedded applications.
   - `/dev/mmcblk0`: The main SD card slot.
   - `/dev/mmcblk1`, `/dev/mmcblk2`, etc.: Additional SD cards or card readers.

## Configuring BIOS/UEFI for USB Drive Bootup

To boot BMROS from a USB drive, you need to configure your system's BIOS or UEFI settings. Here's how to do it:

### Step-by-Step Guide

1. **Enter BIOS/UEFI Setup**:
   - Restart your computer and enter the BIOS/UEFI setup. This is usually done by pressing a key during the boot process (common keys are F2, F12, Delete, or Esc). The specific key varies by manufacturer, so consult your computer’s manual if needed.

2. **Navigate to Boot Settings**:
   - Once in the BIOS/UEFI setup, use the arrow keys to navigate to the Boot menu or Boot Order settings.
   - Look for options like "Boot Sequence," "Boot Order," or "Boot Priority."

3. **Enable USB Boot**:
   - Ensure that USB booting is enabled. This option might be listed under "Boot Options," "Advanced BIOS Features," or "Boot Configuration."
   - If USB booting is disabled, enable it by selecting the option and changing its value to "Enabled."

4. **Set USB Drive as First Boot Device**:
   - Change the boot order so that the USB drive is the first boot device. This ensures the system attempts to boot from the USB drive before any other devices.
   - Use the instructions provided on the BIOS/UEFI screen to move the USB drive to the top of the boot list. This is often done with the arrow keys and the Enter key.

5. **Save and Exit**:
   - Save your changes and exit the BIOS/UEFI setup. This is typically done by pressing F10, but refer to the on-screen instructions or your computer’s manual for the exact key.
   - Your computer should now restart and attempt to boot from the USB drive.

### Copying BMROS to Physical Media

1. **Locate the Drive**:
   - Identify the target drive where you want to install BMROS. Use `lsblk` or `fdisk -l` to list all available drives and partitions.

   ```bash
   lsblk
   ```

   ```bash
   sudo fdisk -l
   ```

2. **Install BMROS to Media**:
   - Use the provided script `create-bmros-media.sh` to copy BMROS to your selected media. Make sure the script has executable permissions.

   ```bash
   ./create-bmros-media.sh /dev/sdX
   ```

   Replace `/dev/sdX` with the appropriate device identifier for your target drive.

### Troubleshooting Tips

- **USB Drive Not Recognized**:
  - Ensure the USB drive is properly connected and recognized by the system.
  - Try using a different USB port, preferably one directly connected to the motherboard.

- **BIOS/UEFI Key Not Working**:
  - Double-check the correct key for entering BIOS/UEFI. If unsure, look up the specific key for your computer model online.

- **Boot Order Not Saving**:
  - Ensure you are saving the changes before exiting the BIOS/UEFI setup. If changes are not being saved, there might be an issue with the BIOS/UEFI firmware.

By following these steps, you can configure your system to boot BMROS from a USB drive, enabling you to install or run BMROS on your target machine. This method ensures a smooth and efficient setup process, making it easier to deploy BMROS across various hardware platforms.