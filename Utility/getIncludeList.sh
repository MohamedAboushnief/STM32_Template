#!/bin/bash

# Check if the necessary commands are available
if ! command -v find >/dev/null || ! command -v printf >/dev/null || ! command -v sed >/dev/null; then
  echo "Error: This script requires 'find', 'printf', and 'sed' commands to be available."
  exit 1
fi

# Use absolute paths
INC_PATH='../Src'
OUTPUT_FILE='../cmake/IncludeList.cmake'

# Run 'find' to locate include folders
APP_INC=$(find "$INC_PATH" -type d \( -name 'Inc' -o -name 'Include' -o -name 'Legacy' \))

# Print the list of include folder to the output file
printf "%s\n" $APP_INC > "$OUTPUT_FILE"

# Remove Empty Line
sed -i '' '/./!d' "$OUTPUT_FILE"

# Remove '../' from paths
sed -i '' 's/\.\.\///g' "$OUTPUT_FILE"

# Adding ${PROJ_PATH}/ to the beginning of each line
sed -i '' 's|^|${PROJ_PATH}/|' "$OUTPUT_FILE"

# Wrap the entire content with the CMake structure
{
  echo "set(include_list \${include_list}"
  cat "$OUTPUT_FILE"
  echo ")"
} > "$OUTPUT_FILE.tmp"

mv "$OUTPUT_FILE.tmp" "$OUTPUT_FILE"
