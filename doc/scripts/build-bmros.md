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

  -j, --cpus <count|n-1|all>            Limit BitBake and recipe parallelism
```

## Build Options

### [Production](../../yocto-meta-layers/meta-bare-metal-router/recipes-core/images/bare-metal-router.bb)

In the production build, after the initial login, the `root` user is removed, and direct access to the Linux OS is restricted.

```bash
./build-bmros.sh -b
```

### [Vanilla](../../yocto-meta-layers/meta-bare-metal-router/recipes-core/images/bare-metal-router-vanilla.bb)

In the vanilla build, after the initial login, the `root` user has unrestricted access to the Linux OS. 
***WARNING:*** The `root` account has no password.

```bash
./build-bmros.sh -v
```

### [Debug](../../yocto-meta-layers/meta-bare-metal-router/recipes-core/images/bare-metal-router-debug.bb)

In the debug build, after the initial login, the `root` user has unrestricted access to the Linux OS. 
***WARNING:*** The `root` account has no password.

```bash
./build-bmros.sh -d
```

### CPU Limits

Use `--cpus` or `-j` to limit both BitBake task concurrency and recipe `make -j`
parallelism. This is useful when a build is making the workstation difficult to
use.

When this option is used, `build-bmros.sh` writes a managed block to
`poky/build-bmros/conf/auto.conf` with:

- `BB_NUMBER_THREADS`
- `PARALLEL_MAKE`
- `PARALLEL_MAKEINST`

Leave one logical CPU free for desktop use:

```bash
./build-bmros.sh --cpus n-1
```

Build with a fixed CPU limit:

```bash
./build-bmros.sh --cpus 6
```

Combine CPU limits with image selection:

```bash
./build-bmros.sh -b --cpus n-1
```

Build the Yocto core minimal image while leaving one logical CPU free:

```bash
./build-bmros.sh -c --cpus n-1
```

The CPU limit applies to the build started by that command. If a previous
BitBake build is already running, stop it cleanly and restart with `--cpus`.

## Build Options When Configuring Layers

### Updating BMROS Layers

This option will copy the BMROS Yocto layer to `poky/layers/meta-bare-metal-router`.

```bash
./build-bmros.sh -u [-b | -v | -d] 
```

### Removing and Updating BMROS Layers

This option will:

- Remove `poky/build-bmros/tmp`.
- Remove `poky/layers/meta-bare-metal-router`.
- Copy the BMROS Yocto layer to `poky/layers/meta-bare-metal-router`.

***Caution***: This option will:

- Cause you to rebuild the image build/tmp directory, which can take some time depending on your build system.
- You will need to rerun [Kernel menuconfig](../menuconfig/kernel.md).

```bash
./build-bmros.sh -r [-b | -v | -d] 
```
