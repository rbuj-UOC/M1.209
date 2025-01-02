#include <mpi.h>
#include <stdio.h>
#include <stdlib.h> /* EXIT_SUCCESS */
#define N 100000

int main(int argc, char* argv[]){
    MPI_Init(&argc, &argv);

    int size, rank;
    MPI_Comm_size(MPI_COMM_WORLD, &size);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    printf("Rank %d is reported\n", rank);
    if (rank == 0) printf("Rank size: %d\n", size);
        int v1[SIZE];
        int v2[SIZE];
    if (rank == 0) {
        int partner = 1;
        for (unsigned int i=0;i<N;i++) {
            MPI_Send(v1, SIZE, MPI_INT, partner, 100, MPI_COMM_WORLD);
            printf("Rank %d sends to %d\n", rank, partner);
        }
        for (unsigned int i=0;i<N;i++) {
            MPI_Recv(v2, SIZE, MPI_INT, partner, 100, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
            printf("Rank %d receives from %d\n", rank, partner);
        }
    }
    else if (rank == 1) {
        int partner = 0;
        for (unsigned int i=0;i<N;i++) {
            MPI_Send(v1, SIZE, MPI_INT, partner, 100, MPI_COMM_WORLD);
            printf("Rank %d sends to %d\n", rank, partner);
        }
        for (unsigned int i=0;i<N;i++) {
            MPI_Recv(v2, SIZE, MPI_INT, partner, 100, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
            printf("Rank %d receives from %d\n", rank, partner);
        }
    }

    MPI_Finalize();

    return 0;
}

