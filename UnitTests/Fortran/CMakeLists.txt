include_directories(${CMAKE_BINARY_DIR}/Source/Fortran)
add_executable(FortranTest main.f90)
target_link_libraries(FortranTest FW)
add_test(FortranTest1 ${MPIEXEC} ${MPIEXEC_NUMPROC_FLAG} 1
  ${CMAKE_BINARY_DIR}/bin/FortranTest --matrix_length 10 --values_to_add 10)
add_test(FortranTest2 ${MPIEXEC} ${MPIEXEC_NUMPROC_FLAG} 2
  ${CMAKE_BINARY_DIR}/bin/FortranTest --matrix_length 10 --values_to_add 10)
add_test(FortranTest3 ${MPIEXEC} ${MPIEXEC_NUMPROC_FLAG} 3
  ${CMAKE_BINARY_DIR}/bin/FortranTest --matrix_length 10 --values_to_add 10)
