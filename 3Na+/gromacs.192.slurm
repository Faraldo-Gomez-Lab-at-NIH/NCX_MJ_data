#!/bin/bash

module purge
module load openmpi/2.1.6/gcc-4.8.5
module load fftw/3.3.7/openmpi-2.1.2/gcc-4.8.5

source /home/marinellif/PROG/gromacs-4.5.5-plumed-mindist_nblist-path20-bin/bin/GMXRC

echo "Running Gromacs 4.5.5 with $SLURM_NTASKS MPI tasks"
echo "Nodelist: $SLURM_NODELIST"

run=192

runo=$((run-1))

# uncomment to extend run
#for((i=0;i<64;i++));do tpbconv_d -f prod_npt_${runo}_${i}.trr -s prod_npt_${runo}_${i}.tpr -e prod_npt_${runo}_${i}.edr -o prod_npt_$((run))_${i}.tpr -extend 1000000 -nice 0; done

inp=prod_npt_${run}_
out=prod_npt_${run}.out

mpirun -np $SLURM_NTASKS /home/marinellif/PROG/gromacs-4.5.5_mindist_nblist_lebo/src/kernel/mdrun -deffnm $inp -plumed META_INP -multi 64 -replex 10000 >& $out
