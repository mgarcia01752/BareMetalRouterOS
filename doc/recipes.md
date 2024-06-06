# Modifying Bare Metal Router Recipes

To customize the Bare Metal Router (BMR) recipes and create your image, follow these steps:

## Creating Image Recipe

### References:
- [YOCTO Image Recipes](https://docs.yoctoproject.org/dev/dev-manual/customizing-images.html)
- [How To Create a Recipe](https://www.youtube.com/watch?v=Apfwyf_yEzI)
- [How To Create a Recipe for a Python Application](https://stackoverflow.com/questions/50436413/write-a-recipe-in-yocto-for-a-python-application)
- [BB Append a Recipe](https://www.youtube.com/watch?v=IxXSABanxEQ)
- [DevTool](https://www.youtube.com/watch?v=HfbwRfurNfM)

## Create a receipe using devtool

cd poky
source oe-init-build-env
devtool add router-shell https://github.com/mgarcia01752/RouterShell.git --srcbranch=main

## bitbake-layers show-recipes

Use `bitbake-layers` to display available BMR recipes:

```bash
cd poky
source oe-init-build-env build-bmr
bitbake-layers show-recipes "bare-metal-router*"
```

- **`cd poky`**: Navigate to your Yocto Project's main directory.
  
- **`source oe-init-build-env build-bmr`**: Initialize the build environment for BMR (if not already done).
  
- **`bitbake-layers show-recipes "bare-metal-router*"`**: Displays all available recipes related to Bare Metal Router, allowing you to identify and work with specific recipes.

## Additional Notes

- **Creating Image Recipe**: Refer to the Yocto Project documentation and video tutorials linked above for guidance on creating custom recipes and modifying existing ones.
  
- **DevTool**: The DevTool is a powerful utility for recipe development and customization. Refer to the linked video for an overview of its capabilities.
  
- **Recipe Modification**: Use BB Appends to modify existing recipes without altering the original recipe files. This approach ensures easier maintenance and updates.

## Next Steps

After identifying the desired recipes and understanding how to modify them, you can proceed to customize the Bare Metal Router image according to your requirements. Be sure to follow best practices and test your changes thoroughly.
