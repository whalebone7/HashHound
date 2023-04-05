# HashHound 
<img width="729" alt="Screen Shot 2023-04-05 at 22 59 25" src="https://user-images.githubusercontent.com/125891350/230230897-ae99e489-1ab8-48ec-8416-104fed5a151b.png">

HashHound is a bash script that can help security researchers find TLS/SSL certificates associated with a given target company and then search Censys for those certificates' SHA256 fingerprints.

# Description
HashHound is designed to automate the process of searching for SSL/TLS certificates associated with a given company, using the publicly available data from the Certificate Transparency logs and the Censys search engine.
HashHound searches the Censys search engine for each SHA256 fingerprint using the "censys" command-line tool. It does this in a loop, displaying the progress of the search as a percentage of the total number of fingerprints. It saves the search results to a text file.

# Requirements

HashHound requires the following tools to be installed on your system:

- Bash

- cURL

- jq

- Censys CLI

# Usage 
1. Install it with git clone && cd HashHound

2. `chmod +x hashhound.sh`

3. `./hashhound.sh "Company name"`

For example: 

`./hashhound.sh Tesla`

4. Wait for the script to finish running. The results will be saved to a file named search_results.txt in the same directory as the script.

5. `cat search_results.txt` 

# Acknowledgments 

This project was written by Whalebone. You can find more of my work at `/whalebone7`.

I would also like to thank the creators of the following tools and technologies that were used in this project:

- Bash: a Unix shell and command language that was used to write the script.
- jq: a lightweight and flexible command-line JSON processor that was used to parse JSON output from crt.sh.
- Censys: a platform that provides internet-wide visibility and intelligence, and was used to search for SHA256 fingerprints extracted from Censys URLs.
- GitHub: a web-based platform for version control and collaboration that was used to host this project.
- Cert.sh: a web service for searching and retrieving SSL/TLS certificate information.


