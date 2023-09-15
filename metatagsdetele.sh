#!/bin/bash

# Specify the input directory containing the video files
input_dir="."

# Specify the output directory where processed files will be saved
output_dir="."

# Loop through all video files in the input directory
for input_file in "$input_dir"/*.mkv; do
    if [ -f "$input_file" ]; then
        # Extract the file name without extension
        filename=$(basename -- "$input_file")
        filename_no_ext="${filename%.*}"

        # Construct the output file path with "clean" appended
        output_file="$output_dir/$filename_no_ext-clean.mkv"

        # Remove metadata using FFmpeg
        ffmpeg -i "$input_file" -metadata title="" -c:v copy -c:a copy "$output_file"

        # Check if FFmpeg successfully processed the file
        if [ $? -eq 0 ]; then
            echo "Processed: $input_file"

            # Delete the original file
            rm "$input_file"
            echo "Deleted: $input_file"
        else
            echo "Failed to process: $input_file"
        fi
    fi
done

