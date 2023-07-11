#include "calc_speed_up.h"
#include <filesystem>
#include <fstream>

static timestamp_t call_dgemm(dgemm_function dgemm);
static timestamp_t call_dgemm(dgemm_function dgemm) {
    constexpr uint32_t trial_no = 11;
    constexpr uint32_t n = N;
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
    std::ofstream debug_file;
    std::cout << "current dir:" << std::filesystem::current_path() << "\n";
    std::string output_file_dir = "debug_block_log/";
    std::string output_file = output_file_dir;
    constexpr bool DEBUG = false;
    if (DEBUG) {
        output_file.append("speed_etc.log");
        if (!std::filesystem::is_directory(output_file_dir) ||
            !std::filesystem::exists(
                output_file_dir)) { // Check if src folder exists
            std::filesystem::create_directory(
                output_file_dir); // create src folder
        }
        debug_file.open(output_file, std::ios_base::app | std::ios_base::out);
        debug_file << "BLOCK_DENOMINATOR: " << BLOCK_DENOMINATOR << "\n";
        for (auto &v : all_dgemm) {
            v.m_epapsed_time = call_dgemm(v.m_f);
            if (v.m_name == "dgemm_unrolled_avx256" ||
                v.m_name == "dgemm_blocked_avx256") {
                debug_file << std::setw(30) << v.m_name
                           << ":  elapsed-time=" << std::setw(10)
                           << v.m_epapsed_time;
                debug_file << "     speed-up=" << std::setw(10)
                           << all_dgemm[0].m_epapsed_time /
                                  static_cast<double>(v.m_epapsed_time);
                debug_file << "\n";
            } else {
                std::cout << std::setw(30) << v.m_name
                          << ":  elapsed-time=" << std::setw(10)
                          << v.m_epapsed_time;
                if (v.m_name != "dgemm_basic") {
                    std::cout << "     speed-up=" << std::setw(10)
                              << all_dgemm[0].m_epapsed_time /
                                     static_cast<double>(v.m_epapsed_time);
                }
                std::cout << "\n";
            }
        }
        debug_file.close();
    } else {
        for (auto &v : all_dgemm) {
            v.m_epapsed_time = call_dgemm(v.m_f);
            std::cout << std::setw(30) << v.m_name
                      << ":  elapsed-time=" << std::setw(10)
                      << v.m_epapsed_time;
            if (v.m_name != "dgemm_basic") {
                std::cout << "     speed-up=" << std::setw(10)
                          << all_dgemm[0].m_epapsed_time /
                                 static_cast<double>(v.m_epapsed_time);
            }
            std::cout << "\n";
        }
    }
}
