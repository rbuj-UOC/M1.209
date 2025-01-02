#include "mpi.h"
#include <stdio.h>
#include <stdlib.h> /* EXIT_SUCCESS */

int main(int argc, char* argv[])
{
  int MyProc, tag=1;
  char msg='A', msg_recpt;
  MPI_Status status;
  
  MPI_Init(&argc, &argv);
  MPI_Comm_rank(MPI_COMM_WORLD, &MyProc);

  printf("Process # %d started \n", MyProc);
  MPI_Barrier(MPI_COMM_WORLD);
  
  if (MyProc == 0)
  {
    printf("Sending message to Proc #1 \n") ;
    MPI_Send(&msg, 1, MPI_CHAR, 1, tag, MPI_COMM_WORLD);
    
    MPI_Recv(&msg_recpt, 1, MPI_CHAR, 1, tag, MPI_COMM_WORLD, &status);
    printf("Recv'd message from Proc #1 \n") ;
  }
  else
  {
    MPI_Recv(&msg_recpt, 1, MPI_CHAR, 0, tag, MPI_COMM_WORLD, &status);
    printf("Recv'd message from Proc #0 \n") ;

    printf("Sending message to Proc #0 \n") ;
    MPI_Send(&msg, 1, MPI_CHAR, 0, tag, MPI_COMM_WORLD);
  }
  
  printf("Finishing proc %d\n", MyProc); 

  MPI_Barrier(MPI_COMM_WORLD); 
  MPI_Finalize();

  return EXIT_SUCCESS;
}
