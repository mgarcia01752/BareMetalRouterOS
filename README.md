# BareMetalRouterOS (WORK IN PROGRESS)

The Bare Metal Router OS (BMROS) is a pure Linux router designed for x86-64 architecture, offering a robust networking solution. Utilizing the power of the Yocto Project and the [RouterShell](https://github.com/mgarcia01752/RouterShell) command-line interface (CLI), BMROS provides a customizable and efficient routing platform.

## Features

- **Linux Router**: BMROS is optimized for x86 architecture, harnessing Linux's reliability and flexibility for networking tasks.
  
- **[RouterShell CLI](https://github.com/mgarcia01752/RouterShell)**: An interactive command-line interface inspired by IOS, RouterShell provides an intuitive and familiar configuration experience for network administrators.

- **Customizable**: Leveraging the Yocto Project, users can customize BMROS extensively to meet specific networking requirements.

## Supported Build OS

- Ubuntu 20.04
- Ubuntu 22.04

## Getting Started

### 1. Install Git

To install Git, execute the following command:

```bash
sudo apt install -y git
```
### 2. Clone BMROS Repository

To clone the BMROS repository, run the following command:

```bash
git clone https://github.com/mgarcia01752/BareMetalRouterOS.git
```

### 3. Setup Yocto Build Environment

Before building BMROS, ensure you have the Ubuntu Yocto build environment set up:

```bash
./setup-yocto-env.sh
```

### 4. Download and Install Yocto Poky (Codename: [Scarthgap](https://docs.yoctoproject.org/next/migration-guides/release-5.0.html))

To download and install Yocto Poky (Scarthgap) for BMROS:

```bash
./install-yocto-poky.sh
```

### 5. [Building Bare Metal Router OS](doc/build-bmros.md)

Use the build script to create the initial Production BMROS image:

```bash
sudo ./build-bmros.sh
```

### 6. [Run Bare Metal Router OS](doc/factory-start.md#step-by-step-instructions)

Verify the functionality of the BMROS image using QEMU:

```bash
sudo ./run-bmros.sh
```

### 7. [Create Boot Media](doc/create-boot-media.md)

Prepare bootable media for BMROS:

```bash
./create-bmros-media.sh -d /dev/[ sdX | mmcblkX ]
```

### 8. [Customize Kernel](doc/kernel.md)

After installing BMROS to your target device, you may need to configure the kernel to install drivers such as ethernet and wireless

```bash
./menuconfig.sh --kernel
```

## Documentation

Detailed instructions and information are available in the [docs](doc/index.md) directory.

### Contents:

- **[Installation Guide](doc/index.md#installation-guide)**: Step-by-step instructions for setting up BMROS.
  
- **[Configuration](doc/index.md#configuration)**: Configuring BMROS using the RouterShell CLI.
  
- **[Customization](doc/index.md#customization)**: Customizing BMROS through the Yocto Project.

## Contributing

Contributions to BMROS are welcome! Whether it's bug fixes, new features, or improvements to documentation, your contributions are valuable.

### How to Contribute

1. **Fork the Repository**: Create your fork of the project on GitHub.
2. **Make Changes**: Implement your changes or additions locally.
3. **Submit a Pull Request**: Send your changes to the main repository.
4. **Code Review**: Your pull request will be reviewed by project maintainers.

## Resources

- **GitHub Repository**: [Bare Metal Router Repository](https://github.com/yocto/bare-metal-router)
- **RouterShell GitHub**: [RouterShell Repository](https://github.com/mgarcia01752/RouterShell)
- **Yocto Project**: [Official Site](https://www.yoctoproject.org/)
- **Poky**: [Scarthgap Release](https://docs.yoctoproject.org/next/migration-guides/release-5.0.html)

## License

The Bare Metal Router OS project is licensed under the [MIT License](https://opensource.org/licenses/MIT). See the [LICENSE](https://github.com/yocto/bare-metal-router/blob/main/LICENSE) file for more details.
