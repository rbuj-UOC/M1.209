#include "mpi.h"
#include <stdio.h>
#include <stdlib.h> /* EXIT_SUCCESS */

#define SIZE 10
#define USERID 8

int main(int argc, char* argv[]){
    MPI_Init(&argc, &argv);

    /* Check that only 2 MPI processes are spawn */
    int size;
    MPI_Comm_size(MPI_COMM_WORLD, &size);
    if(size != 2) {
        printf("This application is meant to be run with 2 MPI processes, not %d.\n", size);
        MPI_Abort(MPI_COMM_WORLD, EXIT_FAILURE);
    }

    /* Get my rank */
    int rank;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);

    int v1[SIZE];
    for (int i = 0; i < SIZE; i++) {
        if (rank == 0) 
            v1[i] = USERID + i;   
        else if (rank == 1)
            v1[i] = (USERID - i) * (-1);   
    }

    /* <<< here your RMA code >>> */
    /* create the window */
    MPI_Win win;
    MPI_Win_create(&v1, /* pre-allocated buffer */
                   SIZE * sizeof(int), /* size in bytes */
                   sizeof(int), /* displacement units */
                   MPI_INFO_NULL, /* info object */
                   MPI_COMM_WORLD, /* communicator */
                   &win /* window object */);

    /* start access epoch */
    MPI_Win_fence(0, win);

    int remote_v1[SIZE];
    if (rank == 0){
        MPI_Get(&remote_v1, /* pre-allocated buffer on RMA origin process */
                SIZE, /* count on RMA origin process */
                MPI_INT, /* type on RMA origin process */
                1, /* rank of RMA target process */
                0, /* displacement on RMA target process */
                SIZE, /* count on RMA target process */
                MPI_INT, /* type on RMA target process */
                win /* window object */);
    }

    /* end access epoch */
    MPI_Win_fence(0, win);

    if (rank == 0){
        for (int i = 0; i < SIZE; i++) {
            printf("[0/%d] index %d value %d\n", size, i, v1[i]);
            printf("[1/%d] index %d value %d\n", size, i, remote_v1[i]);
        }
    }


    MPI_Win_free(&win);
    MPI_Finalize();

    return EXIT_SUCCESS;
}
