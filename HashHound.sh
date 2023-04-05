#!/bin/bash

if [[ -t 1 ]]; then
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    BLUE='\033[0;34m'
    NC='\033[0m' # No Color
else
    RED=''
    GREEN=''
    BLUE=''
    NC=''
fi

if [[ $# -eq 0 ]]; then
    echo -e "${RED}Error:${NC} No company target provided. Usage: ${BLUE}$0 \"Company name\"${NC}"
    exit 1
fi

company_target="$1"

echo -e "                 _                                 _ \n  /\\  /\\__ _ ___| |__   /\\  /\\___  _   _ _ __   __| |\n / /_/ / _\` / __| '_ \\ / /_/ / _ \\| | | | '_ \\ / _\` |\n/ __  / (_| \\__ \\ | | / __  / (_) | |_| | | | | (_| |\n\\/\\_\\_\\/\\__,_|___/_| |_\\/\\_\\_\\/_\\___/ \\__,_|_| |_|\\__,_|\n"



echo -e "${BLUE}HashHound written by the whalebone7. Twitter: whalebone71.${NC}"

echo -e "${GREEN}Retrieving certificate IDs...${NC}"
curl -s "https://crt.sh/?q=${company_target}&output=json" | jq -r '.[].id' | grep -v null > crtIDs.txt

echo -e "${GREEN}Retrieving Censys IDs from certificate details page...${NC}"
cat crtIDs.txt | while read -r ID; do
    curl -s "https://crt.sh/?id=${ID}" | grep "censys" | sed 's/^.*href="\/\/\(.*\)".*$/https:\/\/\1/' >> file.txt
done

echo -e "${GREEN}Extracting SHA256 fingerprints from Censys URLs...${NC}"
cat file.txt | cut -d "/" -f 5 > OnlySha.txt

echo -e "${GREEN}Searching Censys for SHA256 fingerprints...${NC}"
count=$(wc -l < OnlySha.txt)
counter=1
while read -r sha; do
    progress=$((100 * counter / count))
    echo -ne "${GREEN}Searching: $progress% complete\r${NC}"
    censys search $sha >> search_results.txt
    ((counter++))
done < OnlySha.txt

echo -e "${GREEN}Cleaning up temporary files...${NC}"
rm crtIDs.txt file.txt OnlySha.txt

echo -e "${BLUE}Search completed. Results saved to search_results.txt.${NC}"
