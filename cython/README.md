This directory contains various methods to use Cython to accelerate the Python Lebwohl-Lasher model. 

The cythonised version directly here can be set up using the command:

python setup_LebwohlLasher.py build_ext -fi 

The run script is then run using the command:

python run_LebwohlLasher.py <ITERATIONS> <SIZE> <TEMPERATURE> <PLOTFLAG>

To use other Cython versions, please direct yourself to the READMEs within those directories. Thank you!