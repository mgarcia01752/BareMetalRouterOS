#!/usr/bin/env bash

FILE_PATH="/var/flags/bmros.FACTORY_START"

# Check if the file exists
if [ -e "$FILE_PATH" ]; then
  echo "The file $FILE_PATH exists."

  cd /usr/lib/routershell/scripts
  /usr/bin/env python3 /usr/lib/routershell/src/start.sh --factory-reset

  # Remove file
  rm $FILE_PATH

else
  echo "The file $FILE_PATH does not exist."
fi

exit 0
