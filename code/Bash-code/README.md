## Preprocessing the  input data
Before using the **sequence-script.sh** script for downloading in high throughput all the fasta files, Type the following command in your Unix command line to the respective input file(text file) with genome ids. 
### Example
Replace the name of your file containing the R output file with the genomes ftp links to retrieve(txt file which contains the genome ids)
```
dos2unix inputfile.txt
```
*Note*: The reason behind this is that we have to correct for some text file formatting related to your OS (Mac or windows). For more information read about **dos2unix** command. The error that in my case I was addressing was a carrriage return problem(%0D in specific) for more information you can check this link: 
[error info](https://stackoverflow.com/questions/22236197/how-to-remove-0d-from-end-of-url-when-using-wget)
### Last step
Understanding the bash script
<code>
while read line; do  wget -qN $(echo $line| tr -d '\"') -P ./bartonella-50sampleData ; done < barto50.txt
</code>
### Untangle description
**PUT ATTENTION TO BOLD NOTES FROM HERE ON**

<code>while read line; do  wget -qN $(echo $line| tr -d '\"')</code> 

This code reads line by line and get rid of double quotation that can cause some trouble when  using wget.

<code>-P ./bartonella-50sampleData ;</code>

**download it in a desired directory previously created**(directory name *bartonella-50sampleData*). 

<code>barto50.txt</code>

**is the input file modify it accordingly.**
