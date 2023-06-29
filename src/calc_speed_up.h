#pragma once

#include <iomanip>
#include <iostream>
#include <string>
#include <vector>

#include "dgemm_avx256.h"
#include "dgemm_avx512.h"
#include "dgemm_basic.h"
#include "dgemm_basic_blocked.h"
#include "dgemm_blocked.h"
#include "dgemm_openmp.h"
#include "dgemm_unrolled.h"
#include "dgemm_unrolled_avx256.h"
#include "get_timestamp.h"
#include "mtx.h"

using dgemm_function = void (*)(const uint32_t n, const double *a,
                                const double *b, double *c);

class Dgemm {
    public:
        Dgemm(dgemm_function f, const std::string &name)
            : m_f(f), m_name(name) {}

    public:
        dgemm_function m_f;
        const std::string m_name;
        timestamp_t m_epapsed_time{0};
};

void calc_speed_up(std::vector<Dgemm> &all_dgemm_inst);