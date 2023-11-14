# README
## Content
*pangenomix* directory: Tools for pangenome construction, analysis, and comparison. Derived from amr_pangenome, working towards Python2+3 compatibility.
Extracted from Hyun code. Some adaptations are added for further analysis with R.
- *checkMissing.py* and *duplicate.py*: For manual debugging when downloading fastas and looking for missing ids or possible duplicates (if required, sometimes useful). high-throughput detection is implemented in missingFastas.sh(missing id) and within DataCollection.R for duplicate inspections.
- *buildPangenome_main.py*: semiautomatic script for building CDS pangenome. The step-by-step explanation is within the script.
- *toR_main.py*: Transforms presence-absence matrix to Rdataframe for further analysis with micropan package.


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
import pangenomix.pangenome_analysis
import pangenomix.pangenome
from pangenomix.pangenome import list_faa_files
from pangenomix.pangenome import build_cds_pangenome
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
- Step 3: Modify directory names, file names, and paths according to your storage structure.
- Step 4: Run the script and use script comments as guidance. (only works if you clone the repo, comments are based on this assumption. Yet my serve as a reference.)
- 
## Converting to R dataframe: *toR_main.py* Script
**Important Note:** For this workflow I modified the file *sparse_utils.py* with a function call *to_dataFrame_Robject* here in the return value a function named *pandas2ri.py2ri*
is called. This function is strongly dependent on the version of the module *rpy2* version you install. We presume that version 2.9.4 will not have a conflict with the code above. However for version >2.9.4 the name *py2ri* has changed apparently to *py2rpy* (A lot of warnings might throw afterward). Hence using version 2.9.4 of *rpy2* is recommended.

Second conda installation for *rpy2* might show you some problems. So might be that in case of failure, you tried with alternative links mentioned there (I recommend this because conda can also manage its desinstallation and it is within your workspace environment). Last option, if conda fails to install the module then activate your conda environment:

*envname* environment name
```bash
conda activate envname 
```
And then pip install the module
```python
pip install 'rpy2==2.9.4'
```
If another version >2.9.4,like the updated version of 3.5.14,it will have another code structure and the workflow will not work unless you update the functions of rpy2 package to this version.

