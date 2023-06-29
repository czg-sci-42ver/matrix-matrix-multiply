#include "dgemm_unrolled_avx256.h"

#include <x86intrin.h>

#include <cstdio>

/*
Optimized version of DGEMM using C intrinsics to generate the AVX
subword-parallel instructions for the x86 and loop unrolling to create more
opportunities for instruction-level parallelism.

We can see the impact of
instruction-level parallelism by unrolling the loop so that the multiple-issue,
out-of-order execution processor has more instructions to work with.
The function below is the unrolled version of function avx512, which contains
the C intrinsics to produce the AVX-512 instructions.
*/
void dgemm_unrolled_avx256(const uint32_t n, const double *A, const double *B,
                           double *C) {
    // then n must be larger than 4*4
    constexpr uint32_t UNROLL = 4;
    constexpr uint32_t LIMIT = UNROLL * 4;
    if (n <= LIMIT) {
        fprintf(stderr, " %d size smaller than %d", n, LIMIT);
        exit(1);
    }

    for (uint32_t i = 0; i < n; i += UNROLL * 4) {
        for (uint32_t j = 0; j < n; ++j) {
            __m256d c[UNROLL];
            for (uint32_t r = 0; r < UNROLL; r++) {
                c[r] = _mm256_load_pd(C + i + r * 4 + j * n); //[ UNROLL];
            }

            for (uint32_t k = 0; k < n; k++) {
                __m256d bb = _mm256_broadcast_sd(B + j * n + k);
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
