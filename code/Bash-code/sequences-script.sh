#This scripts downloads the fna or the faa files. This also just retrieve for complete(not missing fna or faa)
#Marshall script will deal with duplicates for the filtering
inputfile="$1"
savingDirectory="./$2"
while read line; do  wget -qN $(echo $line| tr -d '\"') -P $savingDirectory  ; done<$inputfile
