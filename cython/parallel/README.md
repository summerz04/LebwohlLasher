This directory contains a cythonised Lebwohl-Lasher model with attempted multithreading. Note that this version was unsuccessful and does not give speed-ups. 

The can be set up using the command:

python setup_parallelpy build_ext -fi 

The run script is then run using the command:

python run_parallel.py <ITERATIONS> <SIZE> <TEMPERATURE> <PLOTFLAG> <THREADS>

To use other Cython versions, please direct yourself to the READMEs within those directories. Thank you!