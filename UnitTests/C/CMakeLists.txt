include_directories(${CMAKE_SOURCE_DIR}/Source/C)
add_executable(CTest main.c)
target_link_libraries(CTest FWWrapper FW)
add_test(CTest1 ${MPIEXEC} ${MPIEXEC_NUMPROC_FLAG} 1
  ${CMAKE_BINARY_DIR}/bin/CTest --matrix_length 10 --values_to_add 10)
add_test(CTest2 ${MPIEXEC} ${MPIEXEC_NUMPROC_FLAG} 2
  ${CMAKE_BINARY_DIR}/bin/CTest --matrix_length 10 --values_to_add 10)
add_test(CTest3 ${MPIEXEC} ${MPIEXEC_NUMPROC_FLAG} 3
  ${CMAKE_BINARY_DIR}/bin/CTest --matrix_length 10 --values_to_add 10)
