################################################################################
# Build file for an intel mkl system.
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_C_COMPILER mpiicc)
set(CMAKE_Fortran_COMPILER mpiifort)
set(CMAKE_CXX_COMPILER mpiicpc)

set(PYTHON_INCLUDE_PATH "/opt/rh/python27/root/usr/include/python2.7/")
set(PYTHON_LIBRARIES "/opt/rh/python27/root/usr/lib64/libpython2.7.so")
set(PYTHON_EXECUTABLE "/opt/rh/python27/root/usr/bin/python")
set(CXX_TOOLCHAINFLAGS "-qopenmp -lgomp -fPIC")
set(F_TOOLCHAINFLAGS "-check bounds -O0 -fpp -qopenmp -fPIC")
