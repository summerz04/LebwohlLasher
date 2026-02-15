import sys
from LebwohlLasher_cython import main

if len(sys.argv) == 5:
    PROGNAME = sys.argv[0]
    ITERATIONS = int(sys.argv[1])
    SIZE = int(sys.argv[2])
    TEMPERATURE = float(sys.argv[3])
    PLOTFLAG = int(sys.argv[4])

    main(PROGNAME, ITERATIONS, SIZE, TEMPERATURE, PLOTFLAG)
else:
    print("Usage: python run_LebwohlLasher.py <ITERATIONS> <SIZE> <TEMPERATURE> <PLOTFLAG>")
