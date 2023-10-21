
outputfilename="$2"
inputfilename="$1"
while read line; do 
	if wget --spider -qN $(echo $line| tr -d '\"');then
		:; 
	else  echo $line>>temp1.txt;fi ; done < $inputfilename

grep -Eo '\.*genomes/(.*)/' temp1.txt|grep -Eo '/(.*)/'|grep -Eo '[^\/]+'>>$outputfilename
rm temp1.txt
