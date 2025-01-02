#include "mpi.h" /* MPI_Init, MPI_Finalize, MPI_Isend, MPI_Irecv, MPI_Waitall,
                    MPI_Comm_size, MPI_Comm_rank, MPI_Request, MPI_COMM_WORLD,
                    MPI_STATUSES_IGNORE */
#include <stdio.h>
#include <stdlib.h> /* EXIT_SUCCESS */
#define SIZE 100000

int main(int argc, char *argv[])
{
  MPI_Init(&argc, &argv);

  /* Check that only 2 MPI processes are spawn */
  int size;
  MPI_Comm_size(MPI_COMM_WORLD, &size);
  if (size != 2)
  {
    printf("This application is meant to be run with 2 MPI processes, not %d.\n", size);
    MPI_Abort(MPI_COMM_WORLD, EXIT_FAILURE);
  }

  /* Get my rank */
  int rank;
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);
  printf("Rank %d is reported\n", rank);
  if (rank == 0)
    printf("Rank size: %d\n", size);

  int v1[SIZE];
  int v2[SIZE];
  MPI_Request requests[2];
  if (rank == 0)
  {
    int partner = 1;
    MPI_Isend(v1, SIZE, MPI_INT, partner, 100, MPI_COMM_WORLD, &requests[0]);
    MPI_Irecv(v2, SIZE, MPI_INT, partner, 100, MPI_COMM_WORLD, &requests[1]);
    MPI_Waitall(2, requests, MPI_STATUSES_IGNORE);
    printf("Rank %d sends to %d\n", rank, partner);
    printf("Rank %d receives from %d\n", rank, partner);
  }
  else if (rank == 1)
  {
    int partner = 0;
    MPI_Isend(v1, SIZE, MPI_INT, partner, 100, MPI_COMM_WORLD, &requests[0]);
    MPI_Irecv(v2, SIZE, MPI_INT, partner, 100, MPI_COMM_WORLD, &requests[1]);
    MPI_Waitall(2, requests, MPI_STATUSES_IGNORE);
    printf("Rank %d sends to %d\n", rank, partner);
    printf("Rank %d receives from %d\n", rank, partner);
  }

  MPI_Finalize();

  return EXIT_SUCCESS;
}
