#include <stdio.h>
#include <stdlib.h> /* rand, srand*/
#include <time.h>   /* clock */
#include <omp.h>    /* omp_get_wtime */
#define NANO_SECONDS 1000000000.0f

int main(int argc, const char *argv[]) {
  double start_sum_time, start_global_time, end_sum_time, end_global_time;
  float *a, sum = 0.0f;
  size_t i, n;

  start_global_time = omp_get_wtime();
  if (argc < 2) {
    printf("Usage: %s SIZE\n", argv[0]);
    exit(-1);
  }
  n = (size_t)abs(atoi(argv[1]));
  a = (float *)malloc(n * sizeof(float));
  srand((unsigned int)clock());
  for (i = 0; i < n; i++)
    /* random number -100,100 */
    a[i] = (((float)rand() / (float)RAND_MAX) - 0.5f) * 200.0f;
  start_sum_time = omp_get_wtime();
#ifdef USE_REDUCTION
  printf("using omp reduction...\n");
#pragma omp parallel for shared(a, n) private(i) reduction(+ : sum)
#else
  printf("not using omp reduction...\n");
#endif
  for (i = 0; i < n; i++)
    sum += a[i];
  end_sum_time = omp_get_wtime();
  free(a);
  end_global_time = omp_get_wtime();
  /* size,sum_time,global_time,result */
  printf("%lu,%f,%f,%.2f\n", n,
         end_sum_time - start_sum_time,
         end_global_time - start_global_time, sum);
  exit(0);
}
