#include <stdio.h>
#include <stdlib.h>
#include <stdlib.h>

int main (int argc, char *argv[]) {
  int    N; //size of columns and rows (matrices)
  int	 i, j, k;
  double **a, **b, **c;
  double *a_block, *b_block, *c_block;
  double **res;
  double *res_block;

  if(argc<2){
    printf("Usage: %s matrix_size\n", argv[0]);
    exit(-1);
  }

  N = abs(atoi(argv[1]));

  a = (double **) malloc(N*sizeof(double *)); /* matrix a to be multiplied */
  b = (double **) malloc(N*sizeof(double *)); /* matrix b to be multiplied */
  c = (double **) malloc(N*sizeof(double *)); /* result matrix c */

  a_block = (double *) malloc(N*N*sizeof(double)); /* Storage for matrices */
  b_block = (double *) malloc(N*N*sizeof(double));
  c_block = (double *) malloc(N*N*sizeof(double));

  /* Result matrix for the sequential algorithm */
  res = (double **) malloc(N*sizeof(double *));
  res_block = (double *) malloc(N*N*sizeof(double));

  for (i=0; i<N; i++)   /* Initialize pointers to a */
    a[i] = a_block+i*N;

  for (i=0; i<N; i++)   /* Initialize pointers to b */
    b[i] = b_block+i*N;
  
  for (i=0; i<N; i++)   /* Initialize pointers to c */
    c[i] = c_block+i*N;

  for (i=0; i<N; i++)   /* Initialize pointers to res */
    res[i] = res_block+i*N;

  for (i=0; i<N; i++) /* last matrix has been initialized */
    for (j=0; j<N; j++)
      a[i][j]= (i+j) * ((double) rand());
  for (i=0; i<N; i++)
    for (j=0; j<N; j++)
      b[i][j]= i * j * ((double) rand());
  for (i=0; i<N; i++)
    for (j=0; j<N; j++)
      c[i][j]= 0.0;

  for (i=0; i<N; i++) {
    for(j=0; j<N; j++) {    
      for (k=0; k<N; k++) {
        c[i][j] += a[i][k] * b[k][j];
      }
    }
  }

  free(a);
  free(b);
  free(c);
  free(a_block);
  free(b_block);
  free(c_block);
  free(res);
  free(res_block);

  printf ("Done.\n");
  exit(0);
}
