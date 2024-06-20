# FAQ

## Issues with permissions

[bmros-profile.bb](../../yocto-meta-layers/meta-bare-metal-router/recipes-core/bmros-startup/bmros-profile.bb) : To modify PATH variables.

## Build Errors

### Simple Fixes

This will remove the build-bmros directory, copy the meta-bare-metal-router directories to /poky and rebuild

```shell
./build-bmros -r|--remove-update-poky-meta-bare-metal-router-layer
```
