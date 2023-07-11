#include "block_denominator.h"
#include <cstdint>
void dgemm_blocked_avx256(const uint32_t n, const double *a, const double *b,
                          double *c);
void dgemm_blocked_avx256_unroll(const uint32_t n, const double *a,
                                 const double *b, double *c);