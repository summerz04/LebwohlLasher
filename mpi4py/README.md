This directory contains files that attempt to implement mpi4py into the Lebwohl-Lasher model.
LebwohlLasher_mpi4py.pi is nonfunctional but attempts to split the lattice between workers.

LebwohlLasher_mpi_mc.py splits MC steps over each worker instead and does indeed run, but may not be working properly due to inefficient runtimes. 

To run LebwohlLasher_mpi_mc.py, please use the command:

mpiexec -n <number of workers> python LebwohlLasher_mpi_mc.py <ITERATIONS> <SIZE> <TEMPERATURE> <PLOTFLAG>