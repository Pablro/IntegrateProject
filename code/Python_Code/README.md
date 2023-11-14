### README
## Content
*pangenomix* directory: Tools for pangenome construction, analysis, and comparison. Derived from amr_pangenome, working towards Python2+3 compatibility.
Extracted from Hyun code. Some adaptations are added for further analysis with R.
- *checkMissing.py* and *duplicate.py*: For manual debugging when downloading fastas and looking for missing ids or possible duplicates (if required, sometimes useful). high-throughput detection is implemented in missingFastas.sh(missing id) and within DataCollection.R for duplicate inspections.
- *buildPangenome_main.py*: semiautomatic script for building CDS pangenome. The step-by-step explanation is within the script.
- *toR_main.py*: Transforms presence-absence matrix to Rdataframe for further analysis with micropan package.


### Instructions
# Building pangenome

## Conda setup

Before creating or activating the conda environment always run the following:

```bash
export PATH="${VSC_DATA}/miniconda3/bin:${PATH}" 
```

### Activate the conda environment

```bash
conda activate ./integrated-project-env/ 
```

### Install cd-hit with bioconda

```bash
conda install -c bioconda cd-hit
```

### Go to pangenomix/pangenomix directory

```bash
cd pangenomix/pangenomix
```

## Approach 1: Python

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
## Approach 2: buildPangenome_main.py





