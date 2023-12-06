# README
## Content
*pangenomix* directory: Tools for pangenome construction, analysis, and comparison. Derived from amr_pangenome, working towards Python2+3 compatibility.
Extracted from Hyun code. Some adaptations are added for further analysis with R.
- *checkMissing.py* and *duplicate.py*: For manual debugging when downloading fastas and looking for missing ids or possible duplicates (if required, sometimes useful). high-throughput detection is implemented in missingFastas.sh(missing id) and within DataCollection.R for duplicate inspections.
- *buildPangenome_main.py*: semiautomatic script for building CDS pangenome. The step-by-step explanation is within the script.
- *toR_main.py*: Transforms presence-absence matrix to Rdataframe for further analysis with micropan package.
- *core_genome_Pieplot*: prints a pie plot belonging to the parts of the pangenome.
- *eggNog_main.py*: semiautomatic script for running eggNog analysis. The step by step explanation is within the script.


## Instructions: Building pangenome

### Conda setup

Before creating or activating the conda environment always run the following:

```bash
export PATH="${VSC_DATA}/miniconda3/bin:${PATH}" 
```

### Activate the conda environment

```bash
conda activate ./integrated-project-env/ 
```

### Load cd-hit with Lmod environment, alternatively install cd-hit with bioconda 
For Lmod
*envname* is your environment name
 ```bash
ml savelist #list your environments
ml restore envname #restore your environment
ml #list your modules, check for CD-Hit
 ```

For conda

```bash
conda install -c bioconda cd-hit
```

### Go to pangenomix/pangenomix directory

```bash
cd pangenomix/pangenomix
```

## Approach 1: Python terminal

### Start a python session

```bash
python
```
You might have to type python3 instead of python

### Import necessary modules

```bash
import pangenome_analysis
import pangenome
from pangenome import list_faa_files
from pangenome import build_cds_pangenome
```

### Create lists of faa files 

```bash
faa_files_50 = list_faa_files("/path/to/50faa/genomes")
faa_files_400 = list_faa_files("/path/to/400faa/genomes")
```
### Create output paths in the desired folder

The easiest way to copy their paths directly via VSC:

<img width="397" alt="image" src="https://github.com/AnnaLew/pangenomix/assets/57362758/72fb102b-bacc-4620-b711-0e7b96fef652">

### Build the pangenome

Make sure to change all the names with each run!

```bash
build_cds_pangenome(genome_faa_paths=faa_files, output_dir="directory/to/cd-hit-output", name="name_of_output")
```

Example

```bash
build_cds_pangenome(genome_faa_paths=faa_files_50, output_dir="directory/to/cd-hit-output/50_bactero_cdhit", name="50bactero")
```
## Approach 2: *buildPangenome_main.py* Script 
Attention: CD-HIT needs to be active.
For conda:
```bash
conda activate envname
```
For Lmod:
```bash
ml savelist #list your environments
ml restore envname #restore your environment
ml #list your modules, check for CD-Hit
```
- Step 1: Activate CD-HIT
- Step 2: Ensure you have the input files (fasta files or fasta directory with the fasta files).
- Step 3: Modify directory names, file names, and paths(if you did not clone the repo) according to your storage structure.
- Step 4: Run the script and use script comments as guidance. (only works if you clone the repo, comments are based on this assumption. Yet these comments might serve as a reference.)
  
## Converting to R dataframe: *toR_main.py* Script
**Important Note:** For this workflow I modified the file *sparse_utils.py* with a function call *to_dataFrame_Robject* here in the return value a function named *pandas2ri.py2ri*
is called. This function is strongly dependent on the version of the module *rpy2* version you install. We presume that version 2.9.4 will not have a conflict with the code above. However for version >2.9.4 the name *py2ri* has changed apparently to *py2rpy* (A lot of warnings might throw afterward). Hence using version 2.9.4 of *rpy2* is recommended.

Second, conda installation for *rpy2* might show you some problems. So might be that in case of failure, you tried with alternative links mentioned here [rpy2 conda installation](https://anaconda.org/conda-forge/rpy2) (I recommend this because conda can also manage its desinstallation and it is within your workspace environment). Last option, if conda fails to install the module then activate your conda environment:

*envname* environment name
```bash
conda activate envname 
```
And then pip install the module
```python
pip install 'rpy2==2.9.4'
```
If another version >2.9.4,like the updated version of 3.5.14,it will have another code structure and the workflow will not work unless you update the functions of rpy2 package to this version.

**Workflow**:
- Step 1: Ensure you have the input files (pangenome files or pangenome directory with the pangenome files).
- Step 2: Modify directory names, file names, and paths(if you did not clone the repo) according to your storage structure.
- Step 3: Run the script *toR_main.py*
  
**Important** Files of the pangenome matrix are required. Specifically all *filename_strain_by_gene.npz* and *filename.strain_by_gene.npz.labels.txt*. Locate this files and modified the code accordingly (to the respective names).
# Fit Heaps Law
## Approach : Python terminal
### Start a python session

```bash
python
```
You might have to type python3 instead of python

### Import necessary modules

```python
import pangenome_analysis, sparse_utils; from pangenome_analysis import estimate_pan_core_size; from pangenome_analysis import fit_heaps_by_iteration
```

### Read the gene.npz file

```python
df_genes = sparse_utils.read_lsdf("path/to/gene.npz")
```

### Create df_pan_core 

df_pan_core is a DataFrame with pangenome + core genome size curve estimates as columns, iterations as index.
Iterations are set to 100 here.

Side note: we can experiment with different numbers here, the number stands for the number of randomizations. 

```python
df_pan_core=estimate_pan_core_size(df_genes, 100)
```

### Calculate the Mean of 100 iterations and plot
Do this immediately after iterations as each time a new run will give different results.
```python
import plot; from plot import calculate_mean
Mean = calculate_mean(df_pan_core, jpgName)
```

### Fit Heaps Law to the mean value of iteration

```python
fit_heaps = fit_heaps_by_iteration(Mean)
```

### Export the result to csv
Save the result of heaps law!
Do this if you want to have the results as csv format.
```python
df_pan_core.to_csv("path/to/.csv")
fit_heaps.to_csv("path/to/.csv")
```
# EggNOG-maper

## Prepare input fasta file

### Important note

You might run into issues if you don't have some libraries installed, so you might want to pip install them beforehand. 

```bash
pip install numpy
pip install pandas
pip install Bio
pip install ast
```

### Start a python session

```bash
python
```
You might have to type python3 instead of python

### Import necessary modules

```python
import allele_identification; from allele_identification import create_alleles_fasta 
```

### Define all input files

Make sure to specify the directory for the output file, sorry for this, it is just the first version, so it's not perfect. 

```python
allele_npz_file = "path/to/allele.npz" 

gene_npz_label_file = "path/to/gene.npz.labels.txt" 

allele_npz_label_file = "path/to/allele.npz.labels.txt" 

input_faa = "path/to/nr.faa" 

output_faa = "path/to/_highly_expressed.faa " 
```

### Create the fasta file

```python
create_alleles_fasta(allele_npz_file, gene_npz_label_file, allele_npz_label_file, input_faa, output_faa) 
```

## Run the EggNog-mapper online tool

Follow the graphical instructions below.

![image](https://github.com/AnnaLew/pangenomix/assets/57362758/bfeca0ea-0f68-4351-bb7f-2146e5e651b0)

![image](https://github.com/AnnaLew/pangenomix/assets/57362758/81dbe9f5-653b-46a8-975d-95d87db0261d)

![image](https://github.com/AnnaLew/pangenomix/assets/57362758/9c0d72c8-9388-4149-a2cb-921ad4d7b094)

After the job finishes running, download the csv and excel files.

![image](https://github.com/AnnaLew/pangenomix/assets/57362758/3e897ab9-a597-4a9c-8692-aabd2dee60d7)

# Core and accessory genome 

This code will allow you to extract the core and accessory pangenomes 

### Important note

You might run into issues if you don't have some libraries installed, so you might want to pip install them beforehand. 

```bash
pip install numpy
pip install pandas
pip install Bio
pip install ast
```

### Start a python session

```bash
python
```
You might have to type python3 instead of python

### Import necessary modules

```python
import core_genome; from core_genome import create_core_genes_fasta 
```

### Define all input files

Make sure to specify the directory for the output file, sorry for this, it is just the first version, so it's not perfect. 

```python
allele_npz_file = "path/to/allele.npz" 

allele_npz_label_file = "path/to/allele.npz.labels.txt"

gene_npz_file = "path/to/gene.npz"

gene_npz_label_file = "path/to/gene.npz.labels.txt"

input_faa = "path/to/nr.faa"

genomes_num = number_of_your_genomes

output_faa = "path/to/_core.faa " 
```

### Very important note

genomes_num variable allows you to decide what in which percentage of genomes you want your genomes to be found. E.g. if you consider core genes the genes present in all the genomes, then set it to 400 in case you have 400 genomes and to 50 in case you have 50 genomes. In our case I want you to run it for the numbers/percentages below.

For 50 genome set:

* 100% - 50
* 98% - 49
* 96% - 48 
* 94% - 47
* 16% - 8

For 400 genome set:

* 100% - 400
* 99% - 396
* 98% - 392
* 96% - 384
* 95% - 380
* 94% - 376
* 16% - 64
* 15% - 60

Also, have in mind that you need to change the name of output file each time, so that you keep track of the percentages.


### Create the fasta file

```python
create_core_genes_fasta(allele_npz_file, allele_npz_label_file, gene_npz_file, gene_npz_label_file, input_faa, genomes_num, output_faa)
```

### Count the number of genes in each fasta file

To count the number of genes in each fasta file, you need to go to the location of the fasta file and then use the following command:

```bash
grep -c "^>" file_core.faa
```
### Generating pie plot for the parts of the pangenome
We summarise the results according to the following thresholds:
* core genes= genome_num probability> 99%
* soft core genes= 95%<genome_num probability<99%
* shell genes= 15%<genome_num probability<95%
* cloud genes= genome_num probability <15%
  
**Workflow**:
- Step 1: Ensure you have the input files (pangenome files or pangenome directory with the pangenome files).
- Step 2: Modify directory names, file names, and paths(if you did not clone the repo) according to your storage structure.
- Step 3: Run the script *core_genome_Pieplot.py*


