#include "mpi.h"
#include <stdio.h>
#include <stdlib.h> /* EXIT_SUCCESS */
#include <unistd.h>

int main(int argc, char **argv)
{
  int rank, numprocs;
  char hostname[256];

  MPI_Init(&argc,&argv);
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);
  MPI_Comm_size(MPI_COMM_WORLD, &numprocs);
  gethostname(hostname,255);
  printf("Hello world! I am process number %d of %d MPI processes on host %s\n",
         rank, numprocs, hostname);
  MPI_Finalize();
  return EXIT_SUCCESS;
}
