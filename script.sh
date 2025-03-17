#!/bin/bash

# Prompt user to specify the IP list file path when starting the script
echo "Please specify the path to your IP list file (e.g., /path/to/ip_list.txt):"
read ip_list_file

# Check if the file exists
if [ ! -f "$ip_list_file" ]; then
  echo "The file $ip_list_file does not exist! Please check the path and try again."
  exit 1
fi

# Get the current date and time in the format YYYY-MM-DD_HH-MM-SS
current_date_time=$(date +"%Y-%m-%d_%H-%M-%S")

# Inform the user that the scan is starting
echo "Scanning IPs from $ip_list_file..."

# Initialize a temporary file to store IPs to scan (including -1 and +1 IPs)
temp_ip_file=$(mktemp)

# Read the IP list and generate the -1 and +1 IPs
while read ip; do
  # Split the IP into base and last octet
  base_ip=$(echo "$ip" | sed 's/\([0-9]*\.[0-9]*\.[0-9]*\)\.[0-9]*/\1/')
  last_octet=$(echo "$ip" | awk -F'.' '{print $4}')
  
  # Calculate the previous and next IPs
  prev_ip="${base_ip}.$((last_octet - 1))"
  next_ip="${base_ip}.$((last_octet + 1))"
  
  # Add the original, previous, and next IPs to the temp file
  echo "$prev_ip" >> "$temp_ip_file"
  echo "$ip" >> "$temp_ip_file"
  echo "$next_ip" >> "$temp_ip_file"
done < "$ip_list_file"

# Remove duplicates from the temp file (just in case)
sort -u "$temp_ip_file" -o "$temp_ip_file"

# Run the Nmap scan with the specified options and save the results with the current date/time
nmap -sT -sC -sV -p- -T4 -O -v -n -Pn --reason -iL "$temp_ip_file" -oA "scan_$current_date_time"

# Remove the temporary IP list file
rm "$temp_ip_file"

# Inform the user that the scan is completed
echo "Scan completed. Results saved to scan_$current_date_time.*"

