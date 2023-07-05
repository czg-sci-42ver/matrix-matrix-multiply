#include <cstdint>
void dgemm_blocked_avx256(const uint32_t n, const double *a, const double *b,
                          double *c);
#ifndef BLOCK_DENOMINATOR
#define BLOCK_DENOMINATOR 20
#endif