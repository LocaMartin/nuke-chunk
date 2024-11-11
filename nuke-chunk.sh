#!/bin/bash

# Function to divide domains into files
divide_domains() {
    local domains=("$@")
    local chunk_size=85
    local base_filename="domains_chunk"
    
    for ((i=0; i<${#domains[@]}; i+=chunk_size)); do
        local start=$((i))
        local end=$((start + chunk_size - 1))
        if [ "$end" -gt "${#domains[@]}-1" ]; then
            end="${#domains[@]}-1"
        fi
        
        echo "${domains[@]:start:end-start+1}" > "${base_filename}$(printf "%03d" $((i/chunk_size)))".txt
    done
}

# Check if input file is provided
if [ $# -eq 0 ]; then
    echo "Error: Please provide the input file name."
    echo "Usage: $0 <input_file>"
    exit 1
fi

# Read domains from the provided file
mapfile -t domains < "$1"

# Divide domains into chunks
divide_domains "${domains[@]}"

# Function to run Nuclei on a single chunk
run_nuclei() {
    local filename="$1"
    echo "Processing $filename..."
    nuclei -l "$filename" -tags cve -c 85 -rl 85 -bs 85 -project -stream -timeout 3 -ss host-spray -mhe 85 >> combined_results.txt
}

# Run Nuclei on each chunk in parallel
parallel --jobs $(nproc) run_nuclei ::: $(ls -1 ${base_filename}*txt)
