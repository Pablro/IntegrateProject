# Bioinformatics Integrated Project
This repository attempts to describes how to perform comparative pangenome analysis. It is based on the Hyun workflow (Hyun et al., 2022). 

The workflow goes as follows.

## Preparing the data

### 1. Download the list of the genomes of interest from the BV-BRC database

a. Go to https://www.bv-brc.org/ and find species of interest.

b. Go to the first genome list under the Taxa section.

c. Go to the Genomes section.

d. Filter the genomes by the following criteria: 
- Public: ‘true',
- Genome Status: ‘complete’,
- ‘WGS’; Genome Quality: ‘good’.

e. Download the CSV file. 

### 2. Convert the .csv to .Rdata format

Run the `code/R_code/LoadingRData.R`. Make sure to adjust the directories.

### 3. Generate a list of genome URLs 

Run the `code/R_code/Unbalanced.R`. Make sure to adjust the directories.`

### 4. Identify the samples that don't have corresponding genome data in the database

Run the `code/Bash-code/missingFastas.sh` script separately on each UnbalancedData.txt in the command line. 

```bash
bash missingFastas.sh NesseUnbalanceData.txt nesseMissing.txt
```

### 4. Filter the data and randomly split the dataset

Run the `code/R_code/DataCollection.R`. Make sure to adjust the directories and names of output files. 

### 5. Download the fasta files

Make sure to change the output directory for every input file. 

```bash
dos2unix InputFile.txt

while read line; do  wget -qN $(echo $line| tr -d '\"') -P ./OutputDirectory ; done < InputFile.txt
```

## Conda

### Download miniconda

For VSC: https://docs.vscentrum.be/software/python_package_management.html

Before creating or activating the conda environment always run the following:

```bash
export PATH="${VSC_DATA}/miniconda3/bin:${PATH}" 
```

### Create a conda environment

Needs to be created only once. 

```bash
conda create --name integrated-project-env  
```

### Activate the conda environment

```bash
conda activate ./integrated-project-env/ 
```
After finishing working with the conda, make sure to deactivate it.

```bash
conda deactivate
```

## Running MLST

For the full documentation go to https://github.com/tseemann/mlst. 

Before running MLST activate the conda environment. 

### Install MLST

```bash
conda install -c conda-forge -c bioconda -c defaults mlst
```
### Run MLST

```bash
mlst --csv genomesDirectory/* > mlstOutput.csv
```
## Running CD-hit

Check the user guide page 8 with http://www.bioinformatics.org/cd-hit/cd-hit-user-guide.pdf.

According to the paper, set the parameter: word size “-n” 5, minimum identity “-T” 80%, minimum alignment length “-aL” 80%, all other settings default.
### Creating the merge file of the non redundant list
Assumptions: All our downloaded data is assumed to be in a non redundant state. This means there is no duplicated id nor missing id faa or fna file.

**Go to the respective directory where all faa files**

*Parameters*

**filename** is the name of the merge file.
```bash
cat *.faa > filename.faa
```
### Run CD-hit
This run CD-HIT is for building a CDS pangenome
```bash
cd-hit -i fastafile -o outputfile -M 0 -n 5 -c 0.8 -aL 0.8 -d 0
```
-c sequence identity threshold

-aL alignment coverage for the longer sequence

## References

Hyun, J.C., Monk, J.M. & Palsson, B.O. Comparative pangenomics: analysis of 12 microbial pathogen pangenomes reveals conserved global structures of genetic and functional diversity. BMC Genomics 23, 7 (2022). https://doi.org/10.1186/s12864-021-08223-8


