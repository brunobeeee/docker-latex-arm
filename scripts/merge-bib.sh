#!/bin/bash

bibDirectory="$PWD/bibDirectory"
outputFile="$PWD/bibliography.bib"

# Wait for bibDirectory to be created
while [ ! -d "$bibDirectory" ]; do
  sleep 1
done

# Wait for .bib files to be present in bibDirectory
while [ -z "$(find "$bibDirectory" -maxdepth 1 -type f -name "*.bib" -print -quit)" ]; do
  sleep 1
done

# Function to merge bibliography
merge_bibliography() {
  # Clear the contents of the output file if it exists
  > "$outputFile"

  # Iterate through all .bib files in the directory and append to the output file
  for bibFile in "$bibDirectory"/*.bib; do
    cat "$bibFile" >> "$outputFile"
    echo "" >> "$outputFile"  # Add an empty line
  done

  echo "Merging completed. The file $outputFile has been updated."
}

echo "Monitoring $bibDirectory for changes..."

# Loop indefinitely, monitoring for changes in the bibDirectory
while true; do
  inotifywait -e modify,create,delete "$bibDirectory"/*.bib
  merge_bibliography
done
