configure_file(test.py.in ${CMAKE_BINARY_DIR}/bin/test.py COPYONLY)

set(TEST_LIST
  PythonTest1
  PythonTest2
  PythonTest3
)

add_test(PythonTest1 ${MPIEXEC} ${MPIEXEC_NUMPROC_FLAG} 1
  ${PYTHON_EXECUTABLE} ${CMAKE_BINARY_DIR}/bin/test.py --matrix_length 10
  --values_to_add 10)
add_test(PythonTest2 ${MPIEXEC} ${MPIEXEC_NUMPROC_FLAG} 2
  ${PYTHON_EXECUTABLE} ${CMAKE_BINARY_DIR}/bin/test.py --matrix_length 10
  --values_to_add 10)
add_test(PythonTest3 ${MPIEXEC} ${MPIEXEC_NUMPROC_FLAG} 3
  ${PYTHON_EXECUTABLE} ${CMAKE_BINARY_DIR}/bin/test.py --matrix_length 10
  --values_to_add 10)
foreach(test_name ${TEST_LIST})
  set_property(TEST ${test_name}
               PROPERTY ENVIRONMENT
               PYTHONPATH=$ENV{PYTHONPATH}:${CMAKE_BINARY_DIR}/python)
  set_property(TEST ${test_name}
               APPEND PROPERTY ENVIRONMENT
               LD_LIBRARY_PATH=$ENV{LD_LIBRARY_PATH}:${CMAKE_BINARY_DIR}/lib)
endforeach(test_name)
#SET_TESTS_PROPERTIES(PythonTest2 PROPERTIES ENVIRONMENT
#  "PYTHONPATH=$ENV{PYTHONPATH}:${CMAKE_BINARY_DIR}/python")
#SET_TESTS_PROPERTIES(PythonTest3 PROPERTIES ENVIRONMENT
#  "PYTHONPATH=$ENV{PYTHONPATH}:${CMAKE_BINARY_DIR}/python")
