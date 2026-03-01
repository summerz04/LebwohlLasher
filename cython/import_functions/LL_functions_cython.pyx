# This .pyx includes the cythonised core functions one_energy, all_energy and MC_step 
# that were identified during profiling as the most inefficient sections. 
# These cythonised functions can then be imported into the main simulation script. 

import numpy as np
import cython 
from libc.math cimport cos, exp 

# cythonised one_energy 
def one_energy(double [:,:] arr, int ix, int iy, int nmax ):
    """
    Arguments:
    arr (float(nmax,nmax)) = array that contains lattice data;
    ix (int) = x lattice coordinate of cell;
    iy (int) = y lattice coordinate of cell;
    nmax (int) = side length of square lattice.
    Description:
    Cythonised function that computes the energy of a single cell of the
    lattice taking into account periodic boundaries.  Working with
    reduced energy (U/epsilon), equivalent to setting epsilon=1 in
    equation (1) in the project notes.
    Returns:
    en (float) = reduced energy of cell.
    """
    cdef double en = 0.0
    cdef int ixp, ixm, iyp, iym 
    cdef double ang, c
    ixp = (ix+1)%nmax # These are the coordinates
    ixm = (ix-1)%nmax # of the neighbours
    iyp = (iy+1)%nmax # with wraparound
    iym = (iy-1)%nmax #
#
# Add together the 4 neighbour contributions
# to the energy
#
    ang = arr[ix,iy]-arr[ixp,iy]

    # using cmath cos operation instead of numpy 
    c = cos(ang)
    en += 0.5*(1.0 - 3.0*c*c)

    ang = arr[ix,iy]-arr[ixm,iy]
    c = cos(ang)
    en += 0.5*(1.0 - 3.0*c*c)

    ang = arr[ix,iy]-arr[ix,iyp]
    c = cos(ang)
    en += 0.5*(1.0 - 3.0*c*c)

    ang = arr[ix,iy]-arr[ix,iym]
    c = cos(ang)
    en += 0.5*(1.0 - 3.0*c*c)


    return en

# cythonised all_energy function
def all_energy(double[:,:] arr, int nmax):
    """
    Arguments:
    arr (float(nmax,nmax)) = array that contains lattice data;
    nmax (int) = side length of square lattice.
    Description:
    Function to compute the energy of the entire lattice. Output
    is in reduced units (U/epsilon).
    Returns:
    enall (float) = reduced energy of lattice.
    """
    cdef double enall = 0.0
    for i in range(nmax):
        for j in range(nmax):
            enall += one_energy(arr,i,j,nmax)
    return enall

# cythonised MC_step function 
def MC_step(double[:,:] arr, double Ts, int nmax):
    """
    Arguments:
    arr (float(nmax,nmax)) = array that contains lattice data;
    Ts (float) = reduced temperature (range 0 to 2);
    nmax (int) = side length of square lattice.
    Description:
    Function to perform one MC step, which consists of an average
    of 1 attempted change per lattice site.  Working with reduced
    temperature Ts = kT/epsilon.  Function returns the acceptance
    ratio for information.  This is the fraction of attempted changes
    that are successful.  Generally aim to keep this around 0.5 for
    efficient simulation.
    Returns:
    accept/(nmax**2) (float) = acceptance ratio for current MCS.
    """
    #
    # Pre-compute some random numbers.  This is faster than
    # using lots of individual calls.  "scale" sets the width
    # of the distribution for the angle changes - increases
    # with temperature.
    cdef int i, j, ix, iy
    cdef double ang, en0, en1, boltz, scale
    
    accept = 0
    scale = 0.1 + Ts

    xran = np.random.randint(0,high=nmax, size=(nmax,nmax))
    yran = np.random.randint(0,high=nmax, size=(nmax,nmax))
    aran = np.random.normal(scale=scale, size=(nmax,nmax))
    for i in range(nmax):
        for j in range(nmax):
            ix = xran[i,j]
            iy = yran[i,j]
            ang = aran[i,j]
            en0 = one_energy(arr,ix,iy,nmax)
            arr[ix,iy] += ang
            en1 = one_energy(arr,ix,iy,nmax)
            if en1<=en0:
                accept += 1
            else:
            # Now apply the Monte Carlo test - compare
            # exp( -(E_new - E_old) / T* ) >= rand(0,1)
                boltz = np.exp( -(en1 - en0) / Ts )

                if boltz >= np.random.uniform(0.0,1.0):
                    accept += 1
                else:
                    arr[ix,iy] -= ang
    return accept/(nmax*nmax)