%%cuda
#include <iostream>

#define N 10

using namespace std;

__global__ void multipicationKernel(const int size,
                                    const double *src_matrix_1,
                                    const double *src_matrix_2,
                                    double *dst_matrix)
{
  // express the collection of blocks, and the collection of threads
  // within a block, as a 2-D array
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

void print_matrix(double m[N][N], string name) {
  std::cout << name << endl;
  for (int i = 0; i < N; i++)
  {
    for (int j = 0; j < N; j++)
    {
      std::cout << m[i][j] << ", ";
    }
    std::cout << endl;
  }
}

int main()
{
  double a[N][N], b[N][N], c[N][N];
  double *d_a, *d_b, *d_c;
  size_t size = N * N * sizeof(double);
  struct timespec t0, t1;

  // alloc space for device copies of a, b, and c
  cudaMalloc((void **)&d_a, size);
  cudaMalloc((void **)&d_b, size);
  cudaMalloc((void **)&d_c, size);

  // initialize matrices
  for (int i = 0; i < N; i++)
  {
    for (int j = 0; j < N; j++)
    {
      a[i][j] = i;
      b[i][j] = j;
    }
  }

  // copy inputs to device
  cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);
  cudaMemcpy(d_b, b, size, cudaMemcpyHostToDevice);

  dim3 dimGrid(1, 1); // grid = 1 x 1 block
  dim3 dimBlock(N, N); // block = N x N threads

  multipicationKernel<<<dimGrid, dimBlock>>>(N, d_a, d_b, d_c);

  cudaMemcpy(c, d_c, size, cudaMemcpyDeviceToHost);

  print_matrix(a, "A");
  print_matrix(b, "B");
  print_matrix(c, "C");

  // clean up
  cudaFree(d_a);
  cudaFree(d_b);
  cudaFree(d_c);

  return 0;
}