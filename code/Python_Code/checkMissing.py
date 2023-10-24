import os

# Read the list of URLs from the text file
with open('400_2.txt', 'r') as file:
    urls = [line.strip('"\n') for line in file]

# List the files in the output300 folder
downloaded_files = os.listdir('output400')

# Check which genomes are not downloaded
not_downloaded = []
for url in urls:
    filename = url.split('/')[-1]
    if filename not in downloaded_files:
        not_downloaded.append(url)

# Print the list of genomes that are not downloaded
for url in not_downloaded:
    print(f"Genome not downloaded: {url}")
