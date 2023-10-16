while read line; do  wget -qN $(echo $line| tr -d '\"') -P ./bartonella-50sampleData ; done < barto50.txt
