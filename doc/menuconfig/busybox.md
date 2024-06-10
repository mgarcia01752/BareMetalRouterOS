# BusyBox Customization

This script is designed to access BusyBox Menuconfig and save the resulting `.config` file to the `meta-bare-metal-router` layer, specifically in the `recipes-core/busybox/files` directory.

## Start MenuConfig

To start BusyBox Menuconfig, use the following command:

```bash
./menuconfig.sh --busybox
```

## BusyBox MenuConfig Navigation

Navigating the `menuconfig` screen involves using the arrow keys, Enter, and Esc. Here are the basic steps for navigating and configuring BusyBox:

1. **Core Utilities**
   - Navigate to: `BusyBox Settings -> Coreutils`
   - Enable or disable utilities as needed for your system.

2. **Networking Utilities**
   - Navigate to: `Networking Utilities`
   - Enable specific networking commands and daemons required for your project.

3. **Process Utilities**
   - Navigate to: `Process Utilities`
   - Customize process-related commands such as `ps`, `top`, and `kill`.

4. **Shell Utilities**
   - Navigate to: `Shells`
   - Select and configure shells like `ash` or `hush` for your environment.

## BusyBox Configuration File

Once you have configured BusyBox, `menuconfig.sh --busybox` will save a copy to `recipes-core/busybox/files/.config`

1. [**menuconfig.sh**](../../menuconfig.sh)

2. [**BusyBox Recipe**](../../yocto-meta-layers/meta-bare-metal-router/recipes-core/busybox/busybox_%25.bbappend)

3. [**BusyBox Configuration**](../../yocto-meta-layers/meta-bare-metal-router/recipes-core/busybox/files/.config)