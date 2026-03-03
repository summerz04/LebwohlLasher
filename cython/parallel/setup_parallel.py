from distutils.core import setup 
from Cython.Build import cythonize
from distutils.extension import Extension

ext_modules = [Extension("LL_cython_parallel", ["LL_cython_parallel.pyx"],
                         extra_compile_args=['-fopenmp'],
            extra_link_args=['-fopenmp']
)]


setup(name="LL_cython_parallel",
      ext_modules=cythonize(ext_modules))
