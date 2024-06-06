# Image Recipe

The Image Recipe section details the different builds of the Bare Metal Router OS (BMROS) tailored for various use cases and deployment scenarios. Each image variant serves a specific purpose, from minimal setups to fully-featured development builds.

## [Core Image Minimal](../../../yocto-meta-layers/meta-bare-metal-router/recipes-core/images/core-image-minimal.bbappend)

The Core Image Minimal is a lightweight version of BMROS designed for systems with limited resources or for use in minimalistic deployments. This image includes only the essential components required to get the router up and running, making it ideal for testing and basic routing tasks.

### Features:
- Minimal set of core utilities and services.
- Basic network configuration.
- Low resource footprint.

## [Bare Metal Router](../../../yocto-meta-layers/meta-bare-metal-router/recipes-core/images/bare-metal-router.bb)

The Bare Metal Router image is intended for production environments. This build includes all necessary features for a fully functional router while maintaining security and performance optimizations.

### Features:
- Comprehensive network device support.
- Security enhancements and optimizations.
- Removed `root` user access after initial setup to enhance security.
- Advanced routing and firewall capabilities.

## [Bare Metal Router Vanilla](../../../yocto-meta-layers/meta-bare-metal-router/recipes-core/images/bare-metal-router-vanilla.bb)

The Bare Metal Router Vanilla image provides a non-debug build that retains `root` user access for administrators who need direct control over the operating system. This version is suitable for scenarios where advanced troubleshooting or direct OS manipulation is required.

### Features:
- Retains `root` access after initial setup.
- Simplified for administrators needing full control.
- Useful for environments where security is managed differently.

### Warning:
- The `root` account has no password by default. Ensure you set a strong password to secure the system.

## [Bare Metal Router Debug](../../../yocto-meta-layers/meta-bare-metal-router/recipes-core/images/bare-metal-router-debug.bb)

The Bare Metal Router Debug image is tailored for development and debugging purposes. This build includes additional tools and configurations to facilitate testing, debugging, and development work on BMROS.

### Features:
- Debugging tools and utilities pre-installed.
- `root` access is available for in-depth system inspection and debugging.
- Enhanced logging and diagnostic capabilities.

### Warning:
- The `root` account has no password by default. Set a strong password to secure the system during development.

Each of these images serves a unique role in the BMROS ecosystem, from lightweight and secure production deployments to versatile development environments. Select the appropriate image based on your specific requirements and use cases.