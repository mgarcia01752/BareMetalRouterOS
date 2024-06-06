# Bare Metal Router OS Layer

The Bare Metal Router OS Layer comprises various recipes essential for the functioning and customization of the router operating system. Here's a breakdown of the core components:

## Recipe Core

This section encompasses the fundamental building blocks of the BMROS, facilitating its functionality and customization.

### [RouterShell](./recipes/router-shell-recipe.md)

The RouterShell provides a command-line interface (CLI) tailored for router configuration and management tasks. It offers essential commands for networking, security, and system administration.

### [Base-Files](./recipes/base-files-recipe.md)

The Base-Files recipe includes essential configuration files and scripts required for the proper operation of BMROS. These files establish the foundational settings and environment necessary for the router's functionality.

### [Images](./recipes/image-recipe.md)

The Images recipe is responsible for generating various system images tailored for different use cases and hardware configurations. These images serve as the deployment packages for BMROS on different router platforms.

### Login-Check

The Login-Check recipe implements authentication mechanisms and user access control features. It ensures secure access to the router's administrative interface and prevents unauthorized access.

### Python

The Python recipe integrates Python scripting capabilities into BMROS, enabling advanced automation and customization tasks. It provides access to the extensive Python ecosystem for developing router-specific applications and utilities.

### Start-up

The Start-up recipe manages the initialization and configuration tasks executed during the system boot process. It ensures that essential services and configurations are set up correctly upon system startup, guaranteeing a smooth and reliable operation of BMROS.
