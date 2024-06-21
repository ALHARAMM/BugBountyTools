#!/bin/bash

# Echo the ASCII art banner
echo "                        AA
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
                 AAAA
"
echo "
____ ____ _    _ _  _  _ ____ ____ ___ _ ____ _  _ 
[__  |  | |    | |\ |  | |___ |     |  | |  | |\ | 
___] |_\| |___ | | \| _| |___ |___  |  | |__| | \| 
                                                   
"

# Prompt the user to enter the domain
echo -n "Enter your domain: "
read domain

if [ -z "$domain" ]; then
    echo "Domain cannot be empty. Exiting."
    exit 1
fi
cd /home/alharam/BugBounty/ParamSpider
python3 paramspider.py -d $domain && for URL in $(</home/alharam/BugBounty/ParamSpider/output/$domain.txt); do (sqlmap -u "${URL}" --risk=3 --level=5 --random-agent --batch); done

