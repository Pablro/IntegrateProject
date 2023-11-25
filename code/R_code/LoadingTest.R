#iMPORTANT NOTE: If the directories structure has changed. This file needs to be modify.
#Follow the navigational directories structure in your local machine.
#For information about assumption of default directory in R:
#the default global working directory in R is in format user/name/Documents
#you can read more about this here: https://statisticsglobe.com/change-default-working-directory-r
#Relevant Note: In this way you can access the RDATA whenever you need it.
#Loading RData
#Remember the default directory in your machines. Later processes start from this point.
# Get the current working directory
current_dir <- getwd()

# Define the relative path to the target directory
relative_path <- file.path("..", "..", "data", "bv-brc-data")

# Construct the full path
full_path <- file.path(current_dir, relative_path)

print(full_path)

# Set the working directory to the full path
#setwd(full_path)
