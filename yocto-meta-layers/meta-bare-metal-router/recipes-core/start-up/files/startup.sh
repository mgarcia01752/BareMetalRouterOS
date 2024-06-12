#!/usr/bin/env bash

FILE_PATH="/var/flags/routershell.FACTORY_START"

# Check if the file exists
if [ -e "$FILE_PATH" ]; then
  echo "The file $FILE_PATH exists."

  cd /usr/lib/routershell/scripts
  /usr/bin/env python3 /usr/lib/routershell/src/factory-reset.py

  # Remove file
  rm $FILE_PATH

else
  echo "The file $FILE_PATH does not exist."
fi
