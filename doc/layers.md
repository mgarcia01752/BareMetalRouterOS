# Adding and Building meta-bare-metal-router

To integrate the meta-bare-metal-router layer into your Yocto Project build environment, follow these steps:

## References

- [YOCTO Layers](https://docs.yoctoproject.org/dev/dev-manual/layers.html)

## Create Bare Metal Router Layer

First, create the meta-bare-metal-router layer within your Yocto Project:

```bash
source oe-init-build-env build-bmr
bitbake-layers create-layer ../meta-bare-metal-router
bitbake-layers add-layer ../meta-bare-metal-router
bitbake-layers show-layers
```

- **`source oe-init-build-env build-bmr`**: This command initializes the build environment for BMR.
  
- **`bitbake-layers create-layer ../meta-bare-metal-router`**: Creates the meta-bare-metal-router layer in your Yocto build directory.
  
- **`bitbake-layers add-layer ../meta-bare-metal-router`**: Adds the newly created layer to the build configuration.
  
- **`bitbake-layers show-layers`**: Displays the layers in your build configuration, confirming that meta-bare-metal-router is added.

## yocto-check-layer meta-bare-metal-router

You can use `yocto-check-layer` to ensure the meta-bare-metal-router layer is properly set up:

```bash
cd poky
source oe-init-build-env build-bmr
yocto-check-layer meta-bare-metal-router 
```

- **`cd poky`**: Navigate to your Yocto Project's main directory.
  
- **`source oe-init-build-env build-bmr`**: Initialize the build environment for BMR (if not already done).
  
- **`yocto-check-layer meta-bare-metal-router`**: Verifies the meta-bare-metal-router layer and its dependencies, ensuring it is correctly configured for the build.

## Additional Notes

- After adding the `meta-bare-metal-router` layer, you can proceed to customize your build by editing configuration files and recipes within this layer.
  
- Refer to the Yocto Project documentation for more details on managing and working with layers: [YOCTO Layers](https://docs.yoctoproject.org/dev/dev-manual/layers.html)

