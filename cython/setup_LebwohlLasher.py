from distutils.core import setup 
from Cython.Build import cythonize
from distutils.extension import Extension

ext_modules = [Extension("LebwohlLasher_cython", ["LebwohlLasher_cython.pyx"],
                         extra_compile_args=['-fopenmp'],
            extra_link_args=['fopenmp']
)]

setup(name="LebwohlLasher_cython",
      ext_modules=cythonize(ext_modules))
