from distutils.core import setup 
from Cython.Build import cythonize

setup(name="LL_core_cython",
      ext_modules=cythonize("LL_core_cython.pyx"))
