# Customize Bare Metal Router Image

## YOCTO Resources

- [Customizing Images](https://docs.yoctoproject.org/dev/dev-manual/customizing-images.html)
- [Customizing Images Video Tutorial](https://www.youtube.com/watch?v=8BIGDRJzZCY)

## Adding Packages via `local.conf` File

To add packages to your Bare Metal Router (BMR) image, you can utilize the `local.conf` configuration file. Here's an example of how to do this:

1. Open your `local.conf` file located in your Yocto Project build directory.
2. Add package names to the `IMAGE_INSTALL_append` variable. For example:
   
   ```conf
   IMAGE_INSTALL:append = " package1 package2 package3"
   ```
   
   Replace `package1`, `package2`, and `package3` with the desired package names.

This will ensure that the specified packages are included when building the BMR image.

## Append `core-image-minimum`

The `core-image-minimum` recipe serves as a base for minimal images. You can append it to include additional features for your BMR image.

- [core-image-minimal.bbappend](../poky/meta-bare-metal-router/recipes-core/images/core-image-minimal.bbappend)

## Extending `core-image-minimum` to Include Bare Metal Router Recipes

To extend `core-image-minimum` and include Bare Metal Router (BMR) specific recipes, you can create a `.bbappend` file.

1. Create a `.bbappend` file for `core-image-minimal` in your BMR layer.
   - Example: `meta-bare-metal-router/recipes-core/images/core-image-minimal.bbappend`

2. Add your customizations to this file, such as additional packages or configurations.
   ```bb
   FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
   SRC_URI += "file://my-custom-script.sh"
   ```

3. Ensure that the necessary recipes are included in your layer's recipes directory.

This `.bbappend` file will extend the `core-image-minimal` recipe specifically for your Bare Metal Router image, allowing you to add custom features or packages tailored to BMR.
