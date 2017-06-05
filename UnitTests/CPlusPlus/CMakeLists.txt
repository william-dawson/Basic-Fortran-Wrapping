include_directories(${CMAKE_SOURCE_DIR}/Source/CPlusPlus)
include_directories(${CMAKE_SOURCE_DIR}/Source/C)
add_executable(CPPTest main.cc)
target_link_libraries(CPPTest FWCPP)
add_test(CPPTest1 ${MPIEXEC} ${MPIEXEC_NUMPROC_FLAG} 1
  ${CMAKE_BINARY_DIR}/bin/CPPTest --matrix_length 10 --values_to_add 10)
add_test(CPPTest2 ${MPIEXEC} ${MPIEXEC_NUMPROC_FLAG} 2
  ${CMAKE_BINARY_DIR}/bin/CPPTest --matrix_length 10 --values_to_add 10)
add_test(CPPTest3 ${MPIEXEC} ${MPIEXEC_NUMPROC_FLAG} 3
  ${CMAKE_BINARY_DIR}/bin/CPPTest --matrix_length 10 --values_to_add 10)
