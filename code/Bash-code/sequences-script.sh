# This script downloads the genomes, takes the list of links to the database as input
#<<<<<<< pablosImplementations
inputfile="$1"
savingDirectory="./$2"
while read line; do  wget -qN $(echo $line| tr -d '\"') -P $savingDirectory  ; done<$inputfile
#=======

while read line; do  wget -qN $(echo $line| tr -d '\"') -P ./bartonella-50sampleData ; done < barto50.txt
#>>>>>>> main
