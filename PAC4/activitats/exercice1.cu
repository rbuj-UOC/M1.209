%%cuda
#include <stdio.h>

__global__ void kernel(){
  // express the collection of blocks, and the collection of threads within a block, as a 1-D array
  int tid = threadIdx.x;
  int bid = blockIdx.x;
  int bdim = blockDim.x;
  int idx = bid * bdim + tid;
  printf("My Id is %d, I am the thread %d of %d in the block %d\n",
         idx, tid, bdim, bid);
}

int main(){
  int bnum = 1;
  int tnum = 9;
  printf("Username: capa08\n");
  printf("Blocks: %d\n", bnum);
  printf("Threads per block: %d\n", tnum);
  kernel<<<bnum,tnum>>>();
  cudaDeviceSynchronize();
  return 0;
}