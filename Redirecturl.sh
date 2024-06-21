#!/bin/bash

# Echo the ASCII art banner
echo -e "                          AA\n                         AAA\n                        AAA\n                       AAA AAA\n                      AAA  AAAA\n                     AAA  AAAAAA\n                    AAA  AAA  AAA\n                   AAA  AAA    AAA\n                  AAA  AAA      AAA\n                 AAAAAAAAAAAAAAAAAAA\n                     AAAA\n                    AAAA\n                   AAAA\n\n __   ___  __     __   ___  __  ___       __      \n|__) |__  |  \\ | |__) |__  /  \`  |  |  | |__) |   \n|  \\ |___ |__/ | |  \\ |___ \\__,  |  \\__/ |  \\ |___\n"

# Prompt the user to enter the domain
echo -n "Enter your domain: "
read domain

if [ -z "$domain" ]; then
    echo "Domain cannot be empty. Exiting."
    exit 1
fi

# Use gau to fetch URLs containing '=https' from the specified domain
gau "$domain" | grep -a -i '=https' | while read -r host; do
    # Replace 'https' with 'http://evil.com' using qsreplace (assuming qsreplace is a valid command in your environment)
    new_url=$(echo "$host" | qsreplace 'http://evil.com')

    # Fetch headers and check if 'evil.com' is present
    if curl -s -L -I "$new_url" | grep -q "evil.com"; then
        echo -e "$host \033[0;31mVulnerable\n"
    fi
done
