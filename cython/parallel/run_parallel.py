import sys
from LL_cython_parallel import main

if len(sys.argv) == 6:
    PROGNAME = sys.argv[0]
    ITERATIONS = int(sys.argv[1])
    SIZE = int(sys.argv[2])
    TEMPERATURE = float(sys.argv[3])
    PLOTFLAG = int(sys.argv[4])
    THREADS = int(sys.argv[5])

    main(PROGNAME, ITERATIONS, SIZE, TEMPERATURE, PLOTFLAG, THREADS)
else:
    print("Usage: python run_parallel.py <ITERATIONS> <SIZE> <TEMPERATURE> <PLOTFLAG> <THREADS>")
