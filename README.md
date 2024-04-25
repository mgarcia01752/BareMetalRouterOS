# BareMetalRouterOS (BMROS)

The Bare Metal Router OS (BMROS) is a pure Linux router designed for x86-64 architecture, offering a robust networking solution. Utilizing the power of the Yocto Project and the [RouterShell](https://github.com/mgarcia01752/RouterShell) command-line interface (CLI), BMR provides a customizable and efficient routing platform.

## Features

- **Linux Router**: BMR is optimized for x86 architecture, harnessing Linux's reliability and flexibility for networking tasks.
  
- **[RouterShell CLI](https://github.com/mgarcia01752/RouterShell)**: An interactive command-line interface inspired by IOS, RouterShell provides an intuitive and familiar configuration experience for network administrators.

- **Customizable**: Leveraging the Yocto Project, users can customize BMR extensively to meet specific networking requirements.

## Getting Started

### 1. Setup Yocto Build Environment

Before building BMR, ensure you have the Ubuntu Yocto build environment set up:

```bash
./setup-yocto-env.sh
```

### 2. Download and Install Poky (Codename: [Scarthgap](https://docs.yoctoproject.org/next/migration-guides/release-5.0.html))

To download and install Poky (Scarthgap) for BMR:

```bash
./install-poky.sh
```

### 3. Building Bare Metal Router

Use the build script to create the initial BMR image:

```bash
./build-bmr.sh
```

### 4. Run Bare Metal Router OS

Verify the functionality of the BMR image using QEMU:

```bash
./run-bmr.sh
```

### 5. Create Boot Media

Prepare bootable media for BMR:

```bash
./create-bmr-boot-media.sh
```

## Documentation

Detailed instructions and information are available in the [docs](doc/index.md) directory.

### Contents:

- **[Installation Guide](doc/index.md#installation-guide)**: Step-by-step instructions for setting up BMR.
  
- **[Configuration](doc/index.md#configuration)**: Configuring BMR using the RouterShell CLI.
  
- **[Customization](doc/index.md#customization)**: Customizing BMR through the Yocto Project.

## Contributing

Contributions to BMR are welcome! Whether it's bug fixes, new features, or improvements to documentation, your contributions are valuable.

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

The Bare Metal Router project is licensed under the [MIT License](https://opensource.org/licenses/MIT). See the [LICENSE](https://github.com/yocto/bare-metal-router/blob/main/LICENSE) file for more details.
