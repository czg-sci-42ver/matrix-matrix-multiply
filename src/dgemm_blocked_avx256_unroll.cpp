#include "dgemm_blocked_avx256.h"

#include <x86intrin.h>

/*
Optimized version of DGEMM using C intrinsics to generate the AVX
subword-parallel instructions for the x86, loop unrolling and blocking to create
more opportunities for instruction-level parallelism.
*/

/*
32 * 20 / 4: 553         402        [.] do_block_avx_256 // 1.3756218905472637
/2: 575         398        [.] do_block_avx_256 // 1.4447236180904524
:625         453        [.] do_block_avx_256 // 1.379690949227373

allows inline
/2 : 524         230        [.] dgemm_blocked_avx256 // 2.2782608695652176
/2 : 418         224        [.] dgemm_blocked_avx256 // 1.8660714285714286

:
610         299        [.] dgemm_unrolled_avx256
506         408        [.] dgemm_blocked_avx256 // 1.2401960784313726

/2:
600         268        [.] dgemm_unrolled_avx256
297         125        [.] dgemm_blocked_avx256 // 2.376

/4:
585         230        [.] dgemm_unrolled_avx256
359         154        [.] dgemm_blocked_avx256 // 2.331168831168831

/5:
545         206        [.] dgemm_unrolled_avx256
371         188        [.] dgemm_blocked_avx256 // 1.9734042553191489

/10:
615         283        [.] dgemm_unrolled_avx256
379         405        [.] dgemm_blocked_avx256 // 0.9358024691358025

/20:
616         268        [.] dgemm_unrolled_avx256
272         266        [.] dgemm_blocked_avx256 // 1.0225563909774436

// above is using `UNROLL * 8` which is wrong with avx256.
// below is `UNROLL * 4`
/40:
speed-up=   16.1246
938         520        [.] dgemm_unrolled_avx256
795         381        [.] dgemm_blocked_avx256 // 2.0866141732283463

/20:
894         460        [.] dgemm_unrolled_avx256
830         713        [.] dgemm_blocked_avx256 // 1.1640953716690041

/10:
944         483        [.] dgemm_unrolled_avx256
982         614        [.] dgemm_blocked_avx256 // 1.5993485342019544

/5:
895         373        [.] dgemm_unrolled_avx256
967         504        [.] dgemm_blocked_avx256 // 1.9186507936507937

/4:
speed-up=   13.1992
946         465        [.] dgemm_unrolled_avx256
943         576        [.] dgemm_blocked_avx256 // 1.6371527777777777

/2:
speed-up=   14.1453
923         505        [.] dgemm_unrolled_avx256
940         328        [.] dgemm_blocked_avx256 // 2.8658536585365852

:
speed-up=   12.2003
912         432        [.] dgemm_unrolled_avx256
1088         588        [.] dgemm_blocked_avx256 // 1.8503401360544218
*/
static constexpr uint32_t BLOCKSIZE = BLOCKSIZE_DEF;

static void
// __attribute__((noinline))
do_block_avx_256(const uint32_t n, const uint32_t si, const uint32_t sj,
                 const uint32_t sk, const double *A, const double *B,
                 double *C) {
    constexpr uint32_t UNROLL = UNROLL_DEF;
    for (uint32_t i = si; i < si + BLOCKSIZE; i += UNROLL * 4) {
        for (uint32_t j = sj; j < sj + BLOCKSIZE; ++j) {
            __m256d c[UNROLL];
            // #pragma GCC unroll 1
            for (uint32_t r = 0; r < UNROLL; r++) {
                c[r] = _mm256_load_pd(C + i + r * 4 + j * n); //[ UNROLL];
            }
            for (uint32_t k = sk; k < sk + BLOCKSIZE; k++) {
                __m256d bb = _mm256_broadcastsd_pd(_mm_load_sd(B + j * n + k));
                // #pragma GCC unroll 1
                for (uint32_t r = 0; r < UNROLL; r++) {
                    c[r] = _mm256_fmadd_pd(
                        _mm256_load_pd(A + n * k + r * 4 + i), bb, c[r]);
                }
            }
            // #pragma GCC unroll 1
            for (uint32_t r = 0; r < UNROLL; r++) {
                _mm256_store_pd(C + i + r * 4 + j * n, c[r]);
            }
        }
    }
}

void dgemm_blocked_avx256_unroll(const uint32_t n, const double *A,
                                 const double *B, double *C) {
    for (uint32_t sj = 0; sj < n; sj += BLOCKSIZE) {
        for (uint32_t si = 0; si < n; si += BLOCKSIZE) {
            for (uint32_t sk = 0; sk < n; sk += BLOCKSIZE) {
                do_block_avx_256(n, si, sj, sk, A, B, C);
            }
        }
    }
}
