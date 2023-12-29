#!/bin/bash

module --force purge
module load openmpi/2.1.6/gcc-4.8.5
module load fftw/3.3.7/openmpi-2.1.2/gcc-4.8.5

source /home/marinellif/PROG/gromacs-4.5.5-plumed-mindist_nblist-path20-bin/bin/GMXRC

echo "Running Gromacs 4.5.5 with $SLURM_NTASKS MPI tasks"
echo "Nodelist: $SLURM_NODELIST"

run=0

runo=$((run-1))
for((i=0;i<16;i++));do tpbconv_d -f equil_${runo}_${i}.trr -s equil_${runo}_${i}.tpr -e equil_${runo}_${i}.edr -o equil_$((run))_${i}.tpr -extend 7500000 -nice 0; done

inp=equil_${run}_
out=equil_${run}.out

mpirun -np $SLURM_NTASKS /home/marinellif/PROG/gromacs-4.5.5_mindist_nblist_lebo/src/kernel/mdrun -deffnm $inp -plumed META_INP -multi 16 -replex 2500 >& $out

