# Base-file Configurations

The base-file configurations include essential system settings that define the behavior and identity of the BMROS. This section covers how to configure the hostname and customize the Message Of The Day (MOTD) for your Bare Metal Router OS.

## Configure Hostname

The hostname configuration determines the unique name assigned to your router on the network. This setting is crucial for network identification and management.

For detailed configuration, view the `base-files` bbappend file:

[View base-files bbappend](../../../yocto-meta-layers/meta-bare-metal-router/recipes-core/base-files/base-files_%25.bbappend)

## Message Of The Day (MOTD)

The Message Of The Day (MOTD) displays a welcome message or important information each time a user logs in to the router. Customizing the MOTD can help communicate system status, contact information, or other relevant details to administrators and users.

For detailed customization, view the `bmr-start-motd` file:

[View base-files bbappend](../../../yocto-meta-layers/meta-bare-metal-router/recipes-core/base-files/files/bmr-start-motd)

