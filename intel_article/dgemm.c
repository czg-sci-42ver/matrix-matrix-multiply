// http://wla.berkeley.edu/~cs61c/fa16/lec/18/code/dgemm.c
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#include <x86intrin.h>

// compile for avx ...
// gcc -O3 -march=broadwell dgemm.c


/* Based on example at
 * https://software.intel.com/en-us/articles/intel-mkl-103-getting-started 
 */

/* NxN matrix multiplication C = A * B. 
 * void dgemm_(int N, double *a, double *b, double *c);
 */

// Scalar;  P&H p. 226
void dgemm_scalar(int N, double *a, double *b, double *c) {
    for (int i=0;  i<N;  i++)
        for (int j=0;  j<N;  j++) {
            double cij = 0;
            for (int k=0;  k<N;  k++)
                //     a[i][k]  * b[k][j]
                cij += a[i+k*N] * b[k+j*N];
            // c[i][j]
            c[i+j*N] = cij;
        }
}

// AVX intrinsics;  P&H p. 227
void dgemm_avx(int N, double *a, double *b, double *c) {
    // avx operates on 4 doubles in parallel
    for (int i=0;  i<N;  i+=4) {
        for (int j=0;  j<N;  j++) {
            // c0 = c[i][j]
            __m256d c0 = {0,0,0,0};
            for (int k=0;  k<N;  k++) {
                c0 = _mm256_add_pd(
                        c0,   // c0 += a[i][k] * b[k][j]
                        _mm256_mul_pd(
                            _mm256_load_pd(a+i+k*N),
                            _mm256_broadcast_sd(b+k+j*N)));
            }
            _mm256_store_pd(c+i+j*N, c0); // c[i,j] = c0
        }
    }
}

// Loop unrolling;  P&H p. 352
const int UNROLL = UNROLL_DEF;

void dgemm_unroll(int n, double *A, double *B, double *C) {
    for (int i=0;  i<n;  i+= UNROLL*4) {
        for (int j=0;  j<n;  j++) {
            __m256d c[4];
            for (int x=0;  x<UNROLL;  x++)
                c[x] = _mm256_load_pd(C+i+x*4+j*n);
            for (int k=0;  k<n;  k++) {
                __m256d b = _mm256_broadcast_sd(B+k+j*n);
                for (int x=0;  x<UNROLL;  x++)
                    c[x] = _mm256_add_pd(c[x],
                           _mm256_mul_pd(_mm256_load_pd(A+n*k+x*4+i), b));
            }
            for (int x=0;  x<UNROLL;  x++) 
                _mm256_store_pd(C+i+x*4+j*n, c[x]);     
        }
    }
}

// Cache blocking;  P&H p. 556
const int BLOCKSIZE = 32;

void do_block(int n, int si, int sj, int sk, double *A, double *B, double *C) {
    for (int i=si;  i<si+BLOCKSIZE;  i+=UNROLL*4)
        for (int j=sj;  j<sj+BLOCKSIZE;  j++) {
            __m256d c[4];
            for (int x=0;  x<UNROLL;  x++)
                c[x] = _mm256_load_pd(C+i+x*4+j*n);
            for (int k=sk;  k<sk+BLOCKSIZE;  k++) {
                __m256d b = _mm256_broadcast_sd(B+k+j*n);
                for (int x=0;  x<UNROLL;  x++)
                    c[x] = _mm256_add_pd(c[x],
                           _mm256_mul_pd(_mm256_load_pd(A+n*k+x*4+i), b));
            }
            for (int x=0;  x<UNROLL;  x++) 
                _mm256_store_pd(C+i+x*4+j*n, c[x]);
        }
}

void dgemm_block(int n, double* A, double* B, double* C) {
    for(int sj=0;  sj<n;  sj+=BLOCKSIZE) 
        for(int si=0;  si<n;  si+=BLOCKSIZE)
            for (int sk=0;  sk<n;  sk += BLOCKSIZE)
                do_block(n, si, sj, sk, A, B, C);
}

// initialize NxN matrix
void init_matrix(int N, double *a) {
    for (int i=0; i<N; i++) {
        for (int j=0; j<N; j++) {
            // keep all entries less than 10. 
            // Pleasing to the eye when printing.
            a[i * N + j] = (i + j + 1) % 10; 
        }
    }
}

// print matrix to stdout
void print_matrix(int N, char *name, double *matrix) {
    printf("\nMatrix %s\n", name);
    for (int i=0;  i<N;  i++) {
        for (int j=0;  j<N;  j++) {
            printf("%8g\t", matrix[N*i+j]);
        }
        printf("\n");
    }
}

// matrix comparison (1 for equal, 0 for not equal)
int equal_matrix(int N, double *a, double *b) {
    double eps = 1e-10;
    for (int i=0;  i<N*N;  i++) {
        if (fabs(a[i]-b[i]) > eps) return 0;
    }
    return 1;
}

typedef void dgemm_func(int N, double *a, double *b, double *c);

double elapsed_time(dgemm_func *deg, int N, double *a, double *b, double *c) {
    int REPEAT = 1024/N;  if (REPEAT < 1) REPEAT = 1;
    double avg_time = 0;
    for (int r=0;  r<REPEAT;  r++) {
        for (int i=0;  i<N*N;  i++) c[i] = 0;
        clock_t start = clock();
        deg(N, a, b, c);
        avg_time += (double)(clock()-start)/CLOCKS_PER_SEC;
    }
    return avg_time/REPEAT;
}

int eval(int N, int n_methods, dgemm_func *methods[]) {
    if (N % 4) {
        printf("N must be a multiple of 4!\n");
        return 1;
    }
    double *a = malloc(N*N*sizeof(double));
    double *b = malloc(N*N*sizeof(double));
    double *c = malloc(N*N*sizeof(double));
    init_matrix(N, a);
    init_matrix(N, b);
    // reference result for "correctness" test
    double *reference = malloc(N*N*sizeof(double));
    dgemm_scalar(N, a, b, reference);
    // print matrices for testing
    if (N < 8) {
        print_matrix(N, "A", a);
        print_matrix(N, "B", b);
        print_matrix(N, "C", reference);
    }
    // iterate over all different dgemm methods
    printf("%4d | ", N);
    double t_ref = 0;
    for (int i=0;  i<n_methods;  i++) {
        double t = elapsed_time(methods[i], N, a, b, c);
        if (i==0) t_ref = t;
        double mflops = 2.0*N*N*N*1e-6;
        if (i==0) printf("%12.2f | ", mflops/t/1000.0);
            else  printf("%10.2f %5.1f | ", mflops/t/1000.0, t_ref/t);
        if (!equal_matrix(N, c, reference)) {
            printf("\n***** ERROR: incorrect result\n");
            return 1;
        }
    }  
    printf("\n");
    free(a);  free(b);  free(c);
    return 0;
}

int main(void) {
    dgemm_func *methods[] = { dgemm_scalar, dgemm_avx, dgemm_unroll, dgemm_block };
    char *method_names[]  = { "scalar",     "avx",     "unrol",      "block" };
    int N[] = { 32, 160, 480, 960 };
    printf("   N | ");
    for (int i=0;  i<sizeof(method_names)/sizeof(char*);  i++) {
        if (i==0) printf("%7s [Gf] | ", method_names[0]);
            else  printf("%5s [Gf] boost | ", method_names[i]);
    }
    printf("\n");
    for (int n=0;  n<sizeof(N)/sizeof(int);  n++)
        if (eval(N[n], sizeof(methods)/sizeof(dgemm_func*), methods)) return 1;
}

