This directory contains files to cythonise all_energy, one_energy and MC_step functions, and import them back into the main Lebwohl-Lasher model to be run. 
The functions to be cythonised are within LL_functions_cython.pyx, and can be set up using the command:

The can be set up using the command:

python setup_LL.py build_ext -fi 

In this case, the main script imports the cythonised functions and essentially is the run script. Therefore, the model can be run using the command:

python LL_import_cython.py <ITERATIONS> <SIZE> <TEMPERATURE> <PLOTFLAG>

To use other Cython versions, please direct yourself to the READMEs within those directories. Thank you!