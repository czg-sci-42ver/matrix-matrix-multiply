#include "calc_speed_up.h"

static timestamp_t call_dgemm(dgemm_function dgemm);
static timestamp_t call_dgemm(dgemm_function dgemm) {
    constexpr uint32_t trial_no = 11;
    constexpr uint32_t n = 32 * 20;
    Mtx a(n), b(n), c(n);

    timestamp_t t{0};

    for (uint32_t i = 0; i < trial_no; i++) {
        a.generate();
        b.generate();
        c.zero();

        const timestamp_t t0 = get_timestamp();
        (*dgemm)(n, a.data(), b.data(), c.data());
        const timestamp_t t1 = get_timestamp();
        t += (t1 - t0);
    }
    return t / static_cast<double>(trial_no);
}

void calc_speed_up(std::vector<Dgemm> &all_dgemm_inst) {
    std::vector<Dgemm> all_dgemm = all_dgemm_inst;

    for (auto &v : all_dgemm) {
        v.m_epapsed_time = call_dgemm(v.m_f);

        std::cout << std::setw(20) << v.m_name
                  << ":  elapsed-time=" << std::setw(10) << v.m_epapsed_time;
        if (v.m_name != "dgemm_basic") {
            std::cout << "     speed-up=" << std::setw(10)
                      << all_dgemm[0].m_epapsed_time /
                             static_cast<double>(v.m_epapsed_time);
        }

        std::cout << "\n";
    }
}
