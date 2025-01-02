#include <stdio.h>
#include <stdlib.h>
#include <stdlib.h>

void func(int x);

int main (int argc, char *argv[]) {
  int    N; //size of columns and rows (matrices)

  if(argc<2){
    printf("Usage: %s matrix_size\n", argv[0]);
    exit(-1);
  }

  N = abs(atoi(argv[1]));

  func(N);

  printf ("Done.\n");
  exit(0);
}
