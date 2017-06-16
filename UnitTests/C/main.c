#include "DistributedArray_c.h"
#include "Wrapper.h"
#include <mpi.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

////////////////////////////////////////////////////////////////////////////////
int main(int argc, char *argv[]) {
  int my_rank;
  int i;
  char matrix_length_s[] = "--matrix_length";
  char values_to_add_s[] = "--values_to_add";
  int matrix_length;
  int values_to_add;
  int DA[SIZE_wrp];
  int next_location;
  double next_value;
  double sum_value;

  MPI_Init(&argc, &argv);
  MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);

  // Process Parameters
  for (i = 1; i < argc; i += 2) {
    if (strcmp(argv[i], matrix_length_s) == 0) {
      matrix_length = atoi(argv[i + 1]);
    } else if (strcmp(argv[i], values_to_add_s) == 0) {
      values_to_add = atoi(argv[i + 1]);
    }
  }

  // Build and Set
  ConstructDistributedArray_wrp(DA, &matrix_length);
  next_value = 1.0;
  for (i = 0; i < values_to_add; ++i) {
    next_location = rand() % matrix_length + 1;
    SetDistributedArrayAt_wrp(DA, &next_location, &next_value);
  }

  // Sum and Print
  sum_value = SumDistributedArray_wrp(DA);
  if (my_rank == 0)
    printf("Sum value %f\n", sum_value);

  // Cleanup
  DestructDistributedArray_wrp(DA);
  MPI_Finalize();
  return 0;
}
