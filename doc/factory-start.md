# Factory or Restart of BMROS

## Initial Start-up or Factory Reset

### BMROS Factory Start

1. Check for FACTORY_START flag in `/var/flags/bmros.FACTORY_START`
2. SysV `init.d/bmros.sh start`
3. Run `/usr/lib/routershell/start.sh --factory-reset`
4. RouterShell will load `/usr/lib/routershell/config/factory-startup.cfg`

### BMROS Restart

1. SysV `init.d/bmros.sh start`
2. Run `/usr/lib/routershell/start.sh`
3. RouterShell will load `/usr/lib/routershell/config/startup-startup.cfg`


## Default Start Login

When you first boot up the system, the default username is `root`, and there is no password set. However, as a security measure, once you create a new username, the `root` account is automatically removed. Follow the steps below to create a new user account and secure your router.

## Connection Options

1. **Console (Serial)**
   - **Serial Connection Settings**: To connect via the console, use a serial connection configured with the following settings:
     - **Baud Rate**: 9600
     - **Data Bits**: 8
     - **Parity**: None
     - **Stop Bits**: 1
   - **Physical Connection**: Use a serial cable to connect your computer's serial port to the router's console port. You might need a USB-to-serial adapter if your computer lacks a serial port.
   - **Terminal Emulation Software**: Use terminal emulation software such as [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html), [Tera Term](https://ttssh2.osdn.jp/index.html.en), or [minicom](https://help.ubuntu.com/community/Minicom). Configure the software with the serial connection settings mentioned above.

2. **Video Output**
   - **Direct Connection**: Connect a monitor to the router's video output port (VGA, HDMI, or similar) and a keyboard to a USB port on the router.
   - **Boot Process**: Power on the router. The BIOS/bootloader messages will be displayed on the monitor.
   - **Login Screen**: Follow the on-screen instructions to log in using the default `root` account and proceed with the normal login procedure as described below.

3. **Network**
   - **Initial Setup**: If using the default build, the network interfaces may not be immediately available. You might need to load a vanilla build to identify the network interface chipset and configure the appropriate drivers via [Kernel Menuconfig](kernel.md).
   - **Kernel Menuconfig**: Access the kernel configuration menu by running `make menuconfig` in the terminal. Navigate to the network drivers section and select the appropriate drivers for your network interfaces. Rebuild the kernel with these settings.
   - **Ethernet Ports**: Once configured, connect to any onboard Ethernet port. By default, all Ethernet ports are bonded and assigned the IP address `192.168.0.100/24`.
   - **Access via Telnet**: Use telnet to connect to the router:
     ```shell
     telnet 192.168.0.100
     ```
   - [**startup-config.cfg**](../yocto-meta-layers/meta-bare-metal-router/recipes-core/router-shell/files/startup-config.cfg): You can costumize your initial address to connect to a headless router.
   - **DHCP and Static IP Configuration**: If needed, you can configure DHCP or static IP settings for your network interfaces by editing the network configuration files, typically located in `/etc/network/interfaces` or similar.

## Step-by-Step Instructions

1. **Login as `root`**: On initial boot, you will be prompted to login. Enter `root` as the username. Since no password is set initially, you will proceed to the next step directly.
   
   ```
   Router login: root
   ```

2. **Create a New User**: You will be prompted to create a new username. Enter your desired username, for example, `dev01`.

   ```shell
   Enter the new username: dev01
   ```

3. **Set a Password**: After entering the new username, you will need to set a password for this new account. The password must be at least 5 characters long and should include a combination of upper and lower case letters, as well as numbers for enhanced security.

   ```shell
   Enter the new password (minimum of 5 characters)
   Please use a combination of upper and lower case letters and numbers.
   New password:
   ```

4. **Confirm the Password**: Re-enter the password to confirm it. If the passwords match, the new password will be set, and the `root` account will be disabled for security reasons.

   ```shell
   Re-enter new password: 
   passwd: password changed.
   ```

5. **Using bare-metal-router-vanilla/debug build**: In this build, the `root` username is retained, allowing direct access to the shell. To initiate the RouterShell, execute the following commands:

```bash
cd /usr/lib/routershell
./start.sh
```

### Important Security Notes

- **Password Strength**: Always use a strong password to ensure the security of your router. A strong password typically includes a mix of upper and lower case letters, numbers, and special characters.
  
- **User Management**: Once the `root` account is removed, manage user accounts carefully. Ensure that you create accounts with the least privilege necessary for users to perform their tasks.

- **System Access**: After the initial setup, you will use the newly created username and password to access the router. Keep your credentials secure and do not share them with unauthorized individuals.

By following these steps, you can ensure that your router is set up securely from the start, minimizing the risk of unauthorized access.