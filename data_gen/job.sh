#!/bin/bash
#SBATCH -J ttlg_corr1 # Job name
#SBATCH -n 128 # Number of cores
#SBATCH -N 1 # Ensure that all cores are on one machine
#SBATCH --time=2-00 # Runtime in D-HH:MM
#SBATCH -p RM
#SBATCH --mem=253000
#SBATCH -o out.out # File to which STDOUT will be written
#SBATCH -e out.err # File to which STDERR will be written


echo "Job started on `hostname` at `date`"
module load matlab/R2021a
matlab -nodisplay -r "run call_dos ; exit"

echo " "
echo "Job Ended at `date`"
