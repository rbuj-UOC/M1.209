%%cuda
#include <iostream>
#include <random>
#include <ctime>
#include <iomanip>

#define N 1000
#define DIVISORS 16

using namespace std;

__global__ void multipicationKernel(const int size,
                                    const double *src_matrix_1,
                                    const double *src_matrix_2,
                                    double *dst_matrix)
{
  // express the collection of blocks, and the collection of threads within a
  // block, as a 2-D array
  int row = blockIdx.x * blockDim.x + threadIdx.x;
  int col = blockIdx.y * blockDim.y + threadIdx.y;
  // Typical problems are not friendly multiples of blockDim.x
  // Avoid accessing beyond the end of the arrays
  if (row < size && col < size)
  {
    double sum = 0;
    for (int k = 0; k < size; k++)
      sum += src_matrix_1[row * size + k] * src_matrix_2[k * size + col];
    dst_matrix[row * size + col] = sum;
  }
}

int main()
{
  double *a, *b, *c;
  double *d_a, *d_b, *d_c;
  size_t size = N * N * sizeof(double);
  struct timespec t0, t1;
  int divisors[DIVISORS] = {1, 2, 4, 5, 8, 10, 20, 25,
                            40, 50, 100, 125, 200, 250, 500, 1000};

  // alloc space for host copies of a, b, and c
  a = (double *) malloc(size);
  b = (double *) malloc(size);
  c = (double *) malloc(size);

  // alloc space for device copies of a, b, and c
  cudaMalloc((void **)&d_a, size);
  cudaMalloc((void **)&d_b, size);
  cudaMalloc((void **)&d_c, size);

  // initialize matrices
  double lower_bound = 0;
  double upper_bound = 10;
  uniform_real_distribution<double> unif(lower_bound, upper_bound);
  default_random_engine re;
  for (int i = 0; i < N; i++)
  {
    for (int j = 0; j < N; j++)
    {
      int idx = (i*N) + j;
      a[idx] = unif(re);
      b[idx] = unif(re);
    }
  }

  // copy inputs to device
  cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);
  cudaMemcpy(d_b, b, size, cudaMemcpyHostToDevice);

  cout << "# blocks / threads, execution time" << endl;
  for (int i=0; i<DIVISORS; i++) {
    dim3 dimGrid(divisors[i], divisors[i]);
    dim3 dimBlock(divisors[DIVISORS-i-1], divisors[DIVISORS-i-1]);

    timespec_get(&t0, TIME_UTC);
    multipicationKernel<<<dimGrid, dimBlock>>>(N, d_a, d_b, d_c);
    cudaMemcpy(c, d_c, size, cudaMemcpyDeviceToHost);
    timespec_get(&t1, TIME_UTC);
    double diff = (double)(t1.tv_sec - t0.tv_sec) + ((double)(t1.tv_nsec - t0.tv_nsec)/1000000000);
    cout << divisors[i] << "b / " << N/divisors[i] << "t, "
         << fixed << setprecision(9) << diff << endl;
  }

  // clean up
  free(a);
  free(b);
  free(c);
  cudaFree(d_a);
  cudaFree(d_b);
  cudaFree(d_c);

  return 0;
}