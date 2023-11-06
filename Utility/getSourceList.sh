#!/bin/bash

# Check if the necessary commands are available
if ! command -v find >/dev/null || ! command -v printf >/dev/null || ! command -v sed >/dev/null; then
  echo "Error: This script requires 'find', 'printf', and 'sed' commands to be available."
  exit 1
fi

# Use absolute paths
SRC_PATH='../Src'
OUTPUT_FILE='../cmake/SourceList.cmake'

# Run 'find' to locate source files
APP_SRC=$(find "$SRC_PATH" -type f \( -name '*.c' -o -name '*.s' \))

# Print the list of source files to the output file
printf "%s\n" $APP_SRC > "$OUTPUT_FILE"

# Remove Empty Line
sed -i '' '/./!d' "$OUTPUT_FILE"

# Remove '../' from paths
sed -i '' 's/\.\.\///g' "$OUTPUT_FILE"

# Adding ${PROJ_PATH}/ to the beginning of each line
sed -i '' 's|^|${PROJ_PATH}/|' "$OUTPUT_FILE"

# Wrap the entire content with the CMake structure
{
  echo "set(source_list \${source_list}"
  cat "$OUTPUT_FILE"
  echo ")"
} > "$OUTPUT_FILE.tmp"

mv "$OUTPUT_FILE.tmp" "$OUTPUT_FILE"
