# Install Yocto Poky to Prepare Bare Metal Router OS Distr 

Installation process for Yocto Poky and the creation of the Bare Metal Router OS (BMROS) distribution.

## [Installation Script](../install-yocto-poky.sh)

### Usage

```bash
Usage: ./install-yocto-poky.sh [options]
Options:
  -p, --install-poky       Install Poky only

```

### Process

1. **Fetching Yocto Poky Directories**: 
   - Creates the local `poky/` workspace if not already present.
   - Clones Yocto 6 source layers under `poky/layers/`.
   - Uses the `yocto-6.0` release ref for BitBake, OpenEmbedded-Core, and meta-yocto.

2. **External Layers Setup**:
   - Clones the Wrynose `meta-openembedded` layer if not already present.
   - Renames Poky to BMROS and updates the configuration to reflect BMROS specifics.

3. **Setting Up Yocto BMROS Build Environment**:
   - Initializes the Yocto build environment, creating necessary directories and configuration files.

4. **Adding Required Layers**:
   - Adds required layers for BMROS, including OpenEmbedded, Python, Networking, and BMROS-specific layers.

5. **Modifying Configuration**:
   - Modifies the `local.conf` file with necessary configurations, such as image types and baseline build settings.
   - Runtime CPU limits can be changed when building with `./build-bmros.sh --cpus <count|n-1|all>`.

6. **Bare Metal Router OS Distribution Installation Complete**:
   - Displays a completion message indicating the successful installation of the BMROS distribution.

### Options

- **Install Poky Only (-p, --install-poky)**: Use this option to install Poky only. It's helpful for scenarios where you need to reinstall Poky or revert to a known good version without modifying other components.
