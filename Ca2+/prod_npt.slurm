#!/bin/bash

module load gromacs/2022.4+plumed2.8.2
name=prod_npt
run=0
#nsteps=$(((run+1)*10000000))
mpirun -np $SLURM_NTASKS gmx_mpi mdrun -deffnm ${name}_0  -multidir ? ?? -replex 10000 -plumed plumed.dat -nsteps 3500000 -noappend -cpi ${name}_0.cpt

