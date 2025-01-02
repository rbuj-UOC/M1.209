#include "mpi.h" /* MPI_Init, MPI_Finalize, MPI_Sendrecv,
                    MPI_Isend, MPI_Irecv, MPI_Waitall, MPI_Request
                    MPI_Comm_size, MPI_Comm_rank, MPI_COMM_WORLD,
                    MPI_STATUS_IGNORE, MPI_STATUSES_IGNORE,
                    MPI_DOUBLE */
#include <stdio.h>
#include <stdlib.h> /* EXIT_SUCCESS */
#define SIZE 8
#define COLS SIZE
#define ROWS 2

int main(int argc, char *argv[])
{
  MPI_Init(&argc, &argv);

  /* Check that only 4 MPI processes are spawn */
  int size;
  MPI_Comm_size(MPI_COMM_WORLD, &size);
  if (size != 4) {
    printf("This application is meant to be run with 2 MPI processes, not %d.\n", size);
    MPI_Abort(MPI_COMM_WORLD, EXIT_FAILURE);
  }

  int rank;
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);
  if (rank == 0)
  {
    double x[ROWS + 1][COLS], x_new[ROWS][COLS], halo[COLS];
    int partner = rank + 1;
    unsigned int i, j;

    printf("Rank size: %d\n", size);

    /* patch initialization */
    for (i = 0; i < COLS; i++)
      x[ROWS][i] = -1.0;
    for (i = 0; i < ROWS; i++)
      for (j = 0; j < COLS; j++)
        x[i][j] = (double)rank;
    printf("Rank %d initialized its own patch\n", rank);
    /* exchange the halos */
    MPI_Sendrecv(x[ROWS - 1], COLS, MPI_DOUBLE, partner, 100,
                 halo, COLS, MPI_DOUBLE, partner, 100,
                 MPI_COMM_WORLD, MPI_STATUS_IGNORE);
    printf("Rank %d sent and received the hallo to/from %d\n",
           rank, partner);
    for (i = 0; i < COLS; i++)
      x[ROWS][i] = halo[i];
    /* print the received halo */
    printf("Rank %d received from %d the halo below\n",
           rank, partner);
    for (j = 0; j < COLS; j++)
    {
      if (j == COLS - 1)
        printf("%.2f\n", halo[j]);
      else
        printf("%.2f, ", halo[j]);
    }
    /* stencil computation of the 1st row */
    i = 0;
    j = 0;
    x_new[i][j] = (x[i][j + 1] + x[i + 1][j]) / 2.0;
    for (j = 1; j < COLS - 1; j++)
      x_new[i][j] = (x[i][j + 1] + x[i][j - 1] + x[i + 1][j]) / 3.0;
    x_new[i][j] = (x[i][j - 1] + x[i + 1][j]) / 2.0;
    /* stencil computation of the 2nd row */
    i = 1;
    j = 0;
    x_new[i][j] = (x[i][j + 1] + x[i + 1][j] + x[i - 1][j]) / 3.0;
    for (j = 1; j < COLS - 1; j++)
      x_new[i][j] = (x[i][j + 1] + x[i][j - 1] + x[i + 1][j] + x[i - 1][j]) / 4.0;
    x_new[i][j] = (x[i][j - 1] + x[i + 1][j] + x[i - 1][j]) / 3.0;
    printf("Rank %d computed the stencil below\n", rank);
    /* print the block result */
    for (i = 0; i < ROWS; i++)
    {
      for (j = 0; j < COLS; j++)
      {
        if (j == COLS - 1)
          printf("%.2f\n", x_new[i][j]);
        else
          printf("%.2f, ", x_new[i][j]);
      }
    }
  }
  else if (rank < size - 1)
  {
    double x[ROWS + 2][COLS], x_new[ROWS][COLS], halos[2][COLS];
    MPI_Request requests[4];
    int partners[2] = {rank - 1, rank + 1};
    unsigned int i, j;

    /* patch initialization */
    for (i = 0; i < COLS; i++)
      x[0][i] = x[ROWS + 1][i] = -1.0;
    for (i = 1; i < ROWS; i++)
      for (unsigned int j = 0; j < COLS; j++)
        x[i][j] = (double)rank;
    /* exchange the halos */
    MPI_Isend(x[1], COLS, MPI_DOUBLE, partners[0], 100,
              MPI_COMM_WORLD, &requests[0]);
    MPI_Isend(x[2], COLS, MPI_DOUBLE, partners[1], 100,
              MPI_COMM_WORLD, &requests[1]);
    MPI_Irecv(halos[0], COLS, MPI_DOUBLE, partners[0], 100,
              MPI_COMM_WORLD, &requests[2]);
    MPI_Irecv(halos[1], COLS, MPI_DOUBLE, partners[1], 100,
              MPI_COMM_WORLD, &requests[3]);
    MPI_Waitall(4, requests, MPI_STATUSES_IGNORE);
    for (i = 0; i < COLS; i++)
    {
      x[0][i] = halos[0][i];
      x[ROWS + 1][i] = halos[1][i];
    }
    /* stencil computation of the two rows */
    for (i = 1; i < i + ROWS; i++)
    {
      j = 0;
      x_new[i][j] = (x[i][j + 1] + x[i + 1][j] + x[i - 1][j]) / 3.0;
      for (j = 1; j < COLS - 1; j++)
        x_new[i][j] = (x[i][j + 1] + x[i][j - 1] + x[i + 1][j] + x[i - 1][j]) / 4.0;
      x_new[i][j] = (x[i][j - 1] + x[i + 1][j] + x[i - 1][j]) / 3.0;
    }
  }
  else
  {
    double x[ROWS + 1][COLS], x_new[ROWS][COLS], halo[COLS];
    int partner = rank - 1;
    unsigned int i, j;

    /* patch initialization */
    for (i = 0; i < COLS; i++)
      x[0][i] = -1.0;
    for (i = 0; i < ROWS; i++)
      for (j = 0; j < COLS; j++)
        x[i][j] = (double)rank;
    /* exchange the halos */
    MPI_Sendrecv(x[1], COLS, MPI_DOUBLE, partner, 100,
                 halo, COLS, MPI_DOUBLE, partner, 100,
                 MPI_COMM_WORLD, MPI_STATUS_IGNORE);
    for (i = 0; i < COLS; i++)
      x[0][i] = halo[i];
    /* stencil computation of the 1st row */
    i = 1;
    j = 0;
    x_new[i][j] = (x[i][j + 1] + x[i + 1][j] + x[i - 1][j]) / 3.0;
    for (j = 1; j < COLS - 1; j++)
      x_new[i][j] = (x[i][j + 1] + x[i][j - 1] + x[i + 1][j] + x[i - 1][j]) / 4.0;
    x_new[i][j] = (x[i][j - 1] + x[i + 1][j] + x[i - 1][j]) / 3.0;
    /* stencil computation of the 2nd row */
    i = 2;
    j = 0;
    x_new[i][j] = (x[i][j + 1] + x[i - 1][j]) / 2.0;
    for (j = 1; j < COLS - 1; j++)
      x_new[i][j] = (x[i][j + 1] + x[i][j - 1] + x[i - 1][j]) / 3.0;
    x_new[i][j] = (x[i][j - 1] + x[i - 1][j]) / 2.0;
  }
  MPI_Finalize();
  return EXIT_SUCCESS;
}
