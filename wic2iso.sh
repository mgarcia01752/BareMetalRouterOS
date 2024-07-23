#!/usr/bin/env bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_wic_image> <output_iso_image>"
    exit 1
fi

INPUT_WIC_IMAGE="$1"
OUTPUT_ISO_IMAGE="$2"
TEMP_RAW_IMAGE="temp_image.raw"

# Check if input WIC image exists
if [ ! -f "$INPUT_WIC_IMAGE" ]; then
    echo "Error: Input WIC image '$INPUT_WIC_IMAGE' not found!"
    exit 1
fi

# Convert WIC image to raw image
echo "Converting WIC image to raw image..."
qemu-img convert -f raw "$INPUT_WIC_IMAGE" -O raw "$TEMP_RAW_IMAGE"

# Create ISO from raw image
echo "Creating ISO image from raw image..."
genisoimage -o "$OUTPUT_ISO_IMAGE" -b "$TEMP_RAW_IMAGE" -c boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -J -r -V "YourISOName" "$TEMP_RAW_IMAGE"

# Clean up temporary raw image
echo "Cleaning up..."
rm "$TEMP_RAW_IMAGE"

echo "ISO image '$OUTPUT_ISO_IMAGE' created successfully!"

exit 0
