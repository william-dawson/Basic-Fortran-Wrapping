#include <iostream>
using std::cout;
using std::endl;
#include <string>
using std::string;
#include <sstream>
using std::stringstream;
#include "DistributedArray.h"
using FW::DistributedArray;
#include <cstdlib>
#include <mpi.h>
using std::rand;

////////////////////////////////////////////////////////////////////////////////
int main(int argc, char *argv[]) {
  MPI_Init(&argc, &argv);
  int my_rank;
  MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);

  // Process Parameters
  string matrix_length_s = "--matrix_length";
  int matrix_length;
  string values_to_add_s = "--values_to_add";
  int values_to_add;
  for (int i = 1; i < argc; i += 2) {
    if (argv[i] == matrix_length_s) {
      stringstream temp(argv[i + 1]);
      temp >> matrix_length;
    } else if (argv[i] == values_to_add_s) {
      stringstream temp(argv[i + 1]);
      temp >> values_to_add;
    }
  }

  // Build and Set
  DistributedArray DA(matrix_length);
  double next_value = 1.0;
  for (int i = 0; i < values_to_add; ++i) {
    int next_location = rand() % matrix_length + 1;
    DA.Set(next_location, next_value);
  }

  // Sum and Print
  double sum_value = DA.Sum();
  if (my_rank == 0)
    cout << "Sum value " << sum_value << endl;

  MPI_Finalize();
  return 0;
}
