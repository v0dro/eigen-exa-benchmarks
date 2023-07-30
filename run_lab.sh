#!/bin/bash

source ~/.bashrc

source /etc/profile.d/modules.sh
module purge
module load gcc/12.2 cuda intel/2022/mkl cmake openmpi/4.0.5

wget https://www.r-ccs.riken.jp/labs/lpnctrt/projects/eigenexa/EigenExa-2.12.tar.gz
tar xvf EigenExa-2.12.tar.gz
cd EigenExa-2.12

mkdir build

./bootstrap
FFLAGS="-std=legacy  -fallow-argument-mismatch" FCFLAGS="-std=legacy  -fallow-argument-mismatch" CXX=mpicxx CC=mpicc F77=mpifort LDFLAGS=" -L${MKLROOT}/lib/intel64 -lmkl_scalapack_lp64 -Wl,--no-as-needed -lmkl_gf_lp64 -lmkl_gnu_thread -lmkl_core -lmkl_blacs_openmpi_lp64 -lgomp -lpthread -lm -ldl" ./configure --enable-mpi=openmpi --prefix=$PWD/build
