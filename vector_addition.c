#include<stdio.h>
#include<time.h>
#include <iostream>
void add(float *x, float *y, int n ){
    for(int i = 0 ; i < n ; i++){
        x[i] += y[i];
    }

}

int main(){
    int N = 1 << 20;
    float *a, *b;
    a = new float[N];
    b = new float[N];
  
    for (int i = 0; i < N; i++){
        a[i] = i * 3.0;
        b[i] = i * 5.0;
    }
    clock_t start = clock();
    add(a,b,N);
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