# Install Yocto Poky to Prepare Bare Metal Router OS Distr 

Installation process for Yocto Poky and the creation of the Bare Metal Router OS (BMROS) distribution.

## [Installation Script](../install-yocto-poky.sh)


### Usage:

```bash
Usage: ./install-yocto-poky.sh [options]
Options:
  -p, --install-poky       Install Poky only
  -s, --install-systemd    Install Systemd, overwrite SystemV

```

### Process:

1. **Fetching Yocto Poky Directories**: 
   - Clones the Yocto Poky repository if not already present.
   - Sets up the Yocto Poky directory.

2. **External Layers Setup**:
   - Clones the meta-intel layer if not already present.
   - Renames the Poky to BMROS and updates the configuration to reflect BMROS specifics.

3. **Setting Up Yocto BMROS Build Environment**:
   - Initializes the Yocto build environment, creating necessary directories and configuration files.

4. **Adding Required Layers**:
   - Adds required layers for BMROS, including OpenEmbedded, Python, Networking, Intel, and BMROS-specific layers.

5. **Modifying Configuration**:
   - Modifies the `local.conf` file with necessary configurations, such as setting parallel build options and image types.

6. **Bare Metal Router OS Distribution Installation Complete**:
   - Displays a completion message indicating the successful installation of the BMROS distribution.

### Options:

- **Install Poky Only (-p, --install-poky)**: Use this option to install Poky only. It's helpful for scenarios where you need to reinstall Poky or revert to a known good version without modifying other components.

- **Install Systemd (-s, --install-systemd)**: This option allows installing Systemd as the system initialization manager, overwriting the default SystemV. Systemd offers advanced features and modernization benefits, but it's essential to assess compatibility and requirements before enabling this option.