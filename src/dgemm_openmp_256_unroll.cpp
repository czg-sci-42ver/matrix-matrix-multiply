#include "dgemm_openmp_256.h"

#include <x86intrin.h>

/*
Optimized version of DGEMM using C intrinsics to generate the AVX
subword-parallel instructions for the x86, loop unrolling and blocking to create
more opportunities for instruction-level parallelism.
*/

static constexpr uint32_t BLOCKSIZE = BLOCKSIZE_DEF;

/*
change 8 to 4
256 -> 256
*/

static void do_block(const uint32_t n, const uint32_t si, const uint32_t sj,
                     const uint32_t sk, const double *A, const double *B,
                     double *C) {
    constexpr uint32_t UNROLL = UNROLL_DEF;
    for (uint32_t i = si; i < si + BLOCKSIZE; i += UNROLL * 4) {
        for (uint32_t j = sj; j < sj + BLOCKSIZE; ++j) {
            __m256d c[UNROLL];
            for (uint32_t r = 0; r < UNROLL; r++) {
                c[r] = _mm256_load_pd(C + i + r * 4 + j * n); //[ UNROLL];
            }
            for (uint32_t k = sk; k < sk + BLOCKSIZE; k++) {
                __m256d bb = _mm256_broadcastsd_pd(_mm_load_sd(B + j * n + k));
                for (uint32_t r = 0; r < UNROLL; r++) {
                    c[r] = _mm256_fmadd_pd(
                        _mm256_load_pd(A + n * k + r * 4 + i), bb, c[r]);
                }
            }
            for (uint32_t r = 0; r < UNROLL; r++) {
                _mm256_store_pd(C + i + r * 4 + j * n, c[r]);
            }
        }
    }
}

void dgemm_openmp_256_unroll(const uint32_t n, const double *A, const double *B,
                             double *C) {
#pragma omp parallel for num_threads(P)
    for (uint32_t sj = 0; sj < n; sj += BLOCKSIZE) {
        for (uint32_t si = 0; si < n; si += BLOCKSIZE) {
            for (uint32_t sk = 0; sk < n; sk += BLOCKSIZE) {
                do_block(n, si, sj, sk, A, B, C);
            }
        }
    }
}
