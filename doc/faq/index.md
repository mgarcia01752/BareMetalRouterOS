# FAQ

## Issues with permissions

[bmros-profile.bb](../../yocto-meta-layers/meta-bare-metal-router/recipes-core/bmros-startup/bmros-profile.bb) : To modify PATH variables.

## Build Errors

### Simple Fixes

This will remove the build-bmros temporary directory, copy the tracked BMROS layer to `poky/layers/meta-bare-metal-router`, and rebuild.

```shell
./build-bmros.sh -r
```

If the build is making the workstation difficult to use, leave one logical CPU
free:

```shell
./build-bmros.sh --cpus n-1
```

You can combine the rebuild and CPU limit options:

```shell
./build-bmros.sh -r --cpus n-1
```
