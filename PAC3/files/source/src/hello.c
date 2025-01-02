#include "mpi.h" /* MPI_Init, MPI_Finalize */
#include <stdio.h>
#include <stdlib.h> /* EXIT_SUCCESS */

int main(int argc, char **argv)
{
  MPI_Init(&argc, &argv);
  printf("Hello World!\n");
  MPI_Finalize();
  return EXIT_SUCCESS;
}
