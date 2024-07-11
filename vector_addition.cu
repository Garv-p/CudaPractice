#include<stdio.h>
#include<time.h>
#include <iostream>
__global__
void add(float *x, float *y, int n ){
    int index = blockIdx.x * blockDim.x + threadIdx.x;
    int stride = blockDim.x * gridDim.x;
    for (int i = index; i < n; i += stride){
      y[i] = x[i] + y[i];
    }

}

int main(){
    int N = 1 << 20;
    float *a, *b;
    cudaMallocManaged(&a, N * sizeof(int));
    cudaMallocManaged(&b, N * sizeof(int));
  
    for (int i = 0; i < N; i++){
        a[i] = i * 3.0;
        b[i] = i * 5.0;
    }        
    clock_t start = clock();
    int blockSize = 256;
    int numBlocks = (N + blockSize - 1) / blockSize;
 
    add<<<numBlocks, blockSize>>>( a, b, N);
    cudaDeviceSynchronize();

    float maxError = 0.0f;
    for (int i = 0; i < N; i++){
        maxError = fmax(maxError, fabs(b[i]-((i*3.0f )+ (i*5.0f))));
    }
      std::cout << "Max error: " << maxError << std::endl;
    

    clock_t end = clock();
  

    double time = (double)(end - start)/ CLOCKS_PER_SEC;
    std::cout << "Time taken: " << time << std::endl;
  

    delete[] a;
    delete[] b;
    return 0;



}