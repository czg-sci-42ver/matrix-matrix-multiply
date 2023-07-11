#ifndef BLOCK_DENOMINATOR
#define BLOCK_DENOMINATOR 20
#endif
#ifndef N
#define N (32 * 30)
#endif
#ifndef BLOCKSIZE_DEF
// #define BLOCKSIZE_DEF (N/BLOCK_DENOMINATOR)
#define BLOCKSIZE_DEF 32
#endif
#ifndef UNROLL_DEF
#define UNROLL_DEF 4
#endif