# Create an empty set to store unique URLs
unique_urls = set()

# List to store duplicate URLs
duplicate_urls = []

# Read the list of URLs from the text file
with open('400_2.txt', 'r') as file:
    for line in file:
        url = line.strip('"\n')
        if url in unique_urls:
            duplicate_urls.append(url)
        else:
            unique_urls.add(url)

# Print the list of duplicate URLs
if duplicate_urls:
    print("Duplicate URLs found:")
    for url in duplicate_urls:
        print(url)
else:
    print("No duplicate URLs found.")
