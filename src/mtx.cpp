#include "mtx.h"

#include <immintrin.h>

#include <algorithm>
#include <cassert>
#include <random>

Mtx::Mtx(uint32_t n) : m_n(n) {
    // m_data = new double[n * n];
    /* why choose 64
    why use _mm_malloc (because it is intel intrinsic, valid both on linux and
    windows ) see
    https://stackoverflow.com/questions/32612881/why-use-mm-malloc-as-opposed-to-aligned-malloc-alligned-alloc-or-posix-mem
    */
    m_data = (double *)_mm_malloc(n * n * sizeof(double), 64);
    // m_data = (double*) _mm_malloc (n * n * sizeof(double), 32);
    // m_data = (double*) _mm_malloc (n * n * sizeof(double), 16);
    // m_data = (double*) _mm_malloc (n * n * sizeof(double), 8);

    /* fail without alignment.*/
    // m_data = (double*) malloc(n * n * sizeof(double));
    if (m_data == nullptr)
        throw std::bad_alloc{}; // ("failed to allocate largest problem size");
}

Mtx::~Mtx() {
    // delete[] m_data;
    _mm_free(m_data);
}

void Mtx::generate(double min_val, double max_val) {
    assert(max_val > min_val);

    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_real_distribution<> dis(min_val, max_val);
    for (uint32_t i = 0; i < m_n * m_n; ++i) {
        m_data[i] = dis(gen);
    }
}

void Mtx::zero() { std::fill(m_data, m_data + m_n * m_n, 0); }
