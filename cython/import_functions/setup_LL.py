from distutils.core import setup 
from Cython.Build import cythonize

setup(name="LL_functions_cython", ext_modules=cythonize("LL_functions_cython.pyx"))



