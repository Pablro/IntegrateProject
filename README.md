# IntegrateProject
Repository for coding of the workflow and data. This project consists of testing Hyun workflow for different species. 

The workflow goes as follows.

## 1. Download the list of the genomes of interest from the BV-BRC database

a. Go to https://www.bv-brc.org/ and find species of interest.

b. Go to the first genome list under the Taxa section.

c. Go to the Genomes section.

d. Filter the genomes by the following criteria: 
- Public: ‘true',
- Genome Status: ‘complete’,
- ‘WGS’; Genome Quality: ‘good’.

e. Download the CSV file. 

## 2. Convert the .csv to .Rdata format

Run the `code/R_code/LoadingRData.R`. Make sure to adjust the directories.

## 3. Generate a list of genome URLs 

Run the `code/R_code/Unbalanced.R`. Make sure to adjust the directories.`

## 4. Identify the samples that don't have corresponding genome data in the database

Run the `code/Bash-code/missingFastas.sh` script separately on each UnbalancedData.txt in the command line. 

```bash
bash missingFastas.sh NesseUnbalanceData.txt nesseMissing.txt
```

## 4. Filter the data and randomly split the dataset

Run the `code/R_code/DataCollection.R`. Make sure to adjust the directories and names of output files. 

## 5. Download the fasta files

Make sure to change the output directory for every input file. 

```bash
dos2unix InputFile.txt

while read line; do  wget -qN $(echo $line| tr -d '\"') -P ./OutputDirectory ; done < InputFile.txt
```
