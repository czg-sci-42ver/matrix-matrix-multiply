#include "calc_speed_up.h"
#include "check.h"

int main() {
    // check();
    std::vector<Dgemm> all_dgemm_inst = {{dgemm_basic, "dgemm_basic"}};
    calc_speed_up(all_dgemm_inst);
    return 0;

    // const double abs_sum_avx256 = calc_abs_sum(n, c_basic.data(),
    // c_avx256.data()); std::cout << abs_sum_avx256 << "\n";
}
