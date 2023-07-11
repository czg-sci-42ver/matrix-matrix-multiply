#include "calc_speed_up.h"
#include "check.h"

int main() {
    // check();
    std::vector<Dgemm> all_dgemm_inst = {
        // {dgemm_basic, "dgemm_basic"},
        // {dgemm_basic_blocked, "dgemm_basic_blocked"},
        // {dgemm_avx256, "dgemm_avx256"},
        {dgemm_unrolled_avx256, "dgemm_unrolled_avx256"},
        // {dgemm_blocked_avx256, "dgemm_blocked_avx256"},
        // {dgemm_openmp_256, "dgemm_openmp_256"},
        {dgemm_openmp_256_unroll, "dgemm_openmp_256_unroll"},
        {dgemm_blocked_avx256_unroll, "dgemm_blocked_avx256_unroll"},
        //{dgemm_avx512, "dgemm_avx512"},
        //{dgemm_unrolled, "dgemm_unrolled"},
        //{dgemm_blocked, "dgemm_blocked"},
    };
    calc_speed_up(all_dgemm_inst);
    return 0;

    // const double abs_sum_avx256 = calc_abs_sum(n, c_basic.data(),
    // c_avx256.data()); std::cout << abs_sum_avx256 << "\n";
}
