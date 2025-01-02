%%cuda
#include <stdio.h>
#include <iostream>
#include <fstream>

//#define INPUT_FILE "test_image.ppm" 
//#define OUTPUT_FILE "output_image.ppm" 

//#define INPUT_FILE "/content/sample_data/test_image.ppm" 
//#define OUTPUT_FILE "/content/sample_data/output_image.ppm" 

#define INPUT_FILE "/content/drive/MyDrive/test_image.ppm" 
#define OUTPUT_FILE "/content/drive/MyDrive/output_image.ppm" 

using namespace std; 

void savePPM(const char *filename, 
             unsigned char *data, 
             int width, 
             int height) { 
    ofstream file(filename, ios::binary); 
    file << "P5\n" << width << " " << height << "\n255\n";

    // Write grayscale data 
    file.write(reinterpret_cast<char *>(data), width * height); 
    file.close(); 
} 

bool loadPPM(const char *filename, 
             unsigned char *data, 
             int width, 
             int height) { 
    ifstream file(filename, ios::binary); 
    if (!file) { 
      cerr << "couldn't find file: " << filename << endl; 
      return false; 
    } 

    string header; 
    file >> header >> width >> height;  // P6, width, height 
    int maxVal; 
    file >> maxVal; 
    file.ignore(); // skip newline 

    file.read(reinterpret_cast<char *>(data), width * height * 3); 
    return true; 
} 

__global__ void kernel(unsigned char *d_A, unsigned char *d_B, int width, int height){
  int x = blockIdx.x * blockDim.x + threadIdx.x;
  int y = blockIdx.y * blockDim.y + threadIdx.y;
  int p = y * width + x; 
  int idx = p * 3; 
    
  // Typical problems are not friendly multiples of blockDim.x 
  // Avoid accessing beyond the end of the arrays 
  if (x < width && y < height) { 
      float gray = 0.3f * d_A[idx] + 
                   0.59f * d_A[idx + 1] + 
                   0.11f * d_A[idx + 2]; 
      d_B[p] = gray;
/*
      printf("x: %d, y: %d %u\n", x, y, (unsigned int)gray);
*/
  } 
}

int main(){
  const int width = 1920, height = 1080; 
  const int n_pixels = width * height;
  const size_t bytes_A = n_pixels * sizeof(unsigned char) * 3; 
  const size_t bytes_B = n_pixels * sizeof(unsigned char); 
  int n = 10;

  // Allocate memory for arrays A, B on host 
  unsigned char *A, *B;
  A = (unsigned char*)malloc(bytes_A);
  B = (unsigned char*)malloc(bytes_B);

  // Allocate memory for arrays d_A, d_B on device 
  unsigned char *d_A, *d_B; 
  cudaMalloc(&d_A, bytes_A); 
  cudaMalloc(&d_B, bytes_B);

  if (!loadPPM(INPUT_FILE, A, width, height)) { 
    // Cleanup 
    free(A); 
    free(B); 
    cudaFree(d_A); 
    cudaFree(d_B); 
    // Raise SIGABRT 
    abort(); 
  } 

  // Copy data from host array A to device array d_A
  cudaMemcpy(d_A, A, bytes_A, cudaMemcpyHostToDevice); 

  dim3 dimGrid(192, 108);
  dim3 dimBlock(n, n);
  kernel<<<dimGrid,dimBlock>>>(d_A, d_B, width, height);

  // Copy data from device array d_B to host array B 
  cudaMemcpy(B, d_B, bytes_B, cudaMemcpyDeviceToHost); 

  savePPM(OUTPUT_FILE, B, width, height); 

  // Cleanup 
  free(A); 
  free(B); 
  cudaFree(d_A); 
  cudaFree(d_B); 

  return 0;
}