# Build Bare Metal Router OS (BMROS)

## Usage

```shell
Usage: ./build-bmros.sh [options]
Options:

  -c, --core-image-minimal              (Yocto core-minimal)
  -b, --bare-metal-router               (Production)
  -d, --bare-metal-router-debug         (Debug)
  -v, --bare-metal-router-vanilla       (Non-Debug)

  -u, --update-poky-meta-bare-metal-router-layer-only
  -r, --remove-update-poky-meta-bare-metal-router-layer
```

## Build Options

### [Production](../yocto-meta-layers/meta-bare-metal-router/recipes-core/images/bare-metal-router.bb)

In the production build, after the initial login, the `root` user is removed, and direct access to the Linux OS is restricted.

```bash
./build-bmros.sh -b
```

### [Vanilla](../yocto-meta-layers/meta-bare-metal-router/recipes-core/images/bare-metal-router-vanilla.bb)

In the vanilla build, after the initial login, the `root` user has unrestricted access to the Linux OS. 
***WARNING:*** The `root` account has no password.

```bash
./build-bmros.sh -v
```

### [Debug](../yocto-meta-layers/meta-bare-metal-router/recipes-core/images/bare-metal-router-debug.bb)

In the debug build, after the initial login, the `root` user has unrestricted access to the Linux OS. 
***WARNING:*** The `root` account has no password.

```bash
./build-bmros.sh -d
```

## Build Options When Configuring Layers

### Updating BMROS Layers

This option will copy the Yocto meta layers to `poky/meta-bare-metal-router`.

```bash
./build-bmros.sh -u [-b | -v | -d] 
```

### Removing and Updating BMROS Layers

This option will:

- Remove `poky/build-bmros/tmp`.
- Remove `poky/meta-bare-metal-router`.
- Copy the Yocto meta layers to `poky/meta-bare-metal-router`.

***Caution***: This option will:
- Cause you to rebuild the image build/tmp directory, which can take some time depending on your build system.
- You will need to rerun [Kernel menuconfig](kernel.md).

```bash
./build-bmros.sh -r [-b | -v | -d] 
```
