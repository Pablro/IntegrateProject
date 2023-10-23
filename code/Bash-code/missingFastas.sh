# This code takes the list of the links to the genomes as input and identifies which are missing from the database

# We need to perform this step as when downloading the links from BV-BRC database, some that don't have a corresponding
# genome are downloaded as well, so we need to identify and remove them from our list

outputfilename="$2"
inputfilename="$1"
while read line; do 
	if wget --spider -qN $(echo $line| tr -d '\"');then
		:; 
	else  echo $line>>temp1.txt;fi ; done < $inputfilename

grep -Eo '\.*genomes/(.*)/' temp1.txt|grep -Eo '/(.*)/'|grep -Eo '[^\/]+'>>$outputfilename
rm temp1.txt
