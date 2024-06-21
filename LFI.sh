#!/bin/bash

# ASCII art banner
echo "
                        AA
                       AAA
                      AAA
                     AAA AAA
                    AAA  AAAA
                   AAA  AAAAAA
                  AAA  AAA  AAA
                 AAA  AAA    AAA
                AAA  AAA      AAA
               AAAAAAAAAAAAAAAAAAA
                   AAAA
                  AAAA
                 AAAA"
echo "
.%%......%%%%%%..%%%%%%.
.%%......%%........%%...
.%%......%%%%......%%...
.%%......%%........%%...
.%%%%%%..%%......%%%%%%.
........................
"

# Prompt the user to enter the domain
echo -n "Enter your domain: "
read domain

# Validate domain input
if [ -z "$domain" ]; then
    echo "Domain cannot be empty. Exiting."
    exit 1
fi

# Change directory to ParamSpider
cd /home/alharam/BugBounty/ParamSpider

# Run ParamSpider to find parameters
python3 paramspider.py -d "$domain"

# Check if ParamSpider output file exists
output_file="/home/alharam/BugBounty/ParamSpider/output/$domain.txt"
if [ ! -f "$output_file" ]; then
    echo "ParamSpider did not generate expected output file. Exiting."
    exit 1
fi

# Iterate through each URL in the ParamSpider output and run ffuf
while IFS= read -r URL; do
    ffuf -u "${URL}" -c -w '/home/alharam/Templates/PayloadsAllTheThings/Directory Traversal/Intruder/LFI-Jhaddix.txt' -ac
done < "$output_file"

# Optional: Add error handling for ffuf if necessary

echo "Script completed."
