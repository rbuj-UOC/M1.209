#include <stdlib.h>
#include <stdio.h>
#ifdef _OPENMP
#include <omp.h>
#endif
#define SIZE 1000

int main()
{
  float matrixa[SIZE][SIZE], matrixb[SIZE][SIZE], mresult[SIZE][SIZE];
  int i, j, k;

  /* Initialize the Matrix arrays */
  for (i = 0; i < SIZE * SIZE; i++)
  {
    mresult[0][i] = 0.0f;
    matrixa[0][i] = matrixb[0][i] = ((float)rand()) * 1.1f;
  }

  /* Matrix-Matrix multiply */
#ifdef _OPENMP
#pragma omp parallel for private(i, j, k) shared(matrixa, matrixb, mresult)
#endif
  for (i = 0; i < SIZE; i++)
    for (j = 0; j < SIZE; j++)
      for (k = 0; k < SIZE; k++)
        mresult[i][j] = mresult[i][j] + matrixa[i][k] * matrixb[k][j];

  exit(0);
}
