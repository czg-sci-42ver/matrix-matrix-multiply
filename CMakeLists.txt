cmake_minimum_required(VERSION 3.0)

project(dgemm)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_BUILD_TYPE Release)

# same as `make VERBOSE=1`
# https://stackoverflow.com/questions/12823799/cmake-how-to-show-the-compilers-stdout?rq=4
# set(CMAKE_VERBOSE_MAKEFILE ON)

# set(CMAKE_CXX_FLAGS "-static-libasan -fsanitize=address -lefence -Wall -Wextra
# -Wpedantic -g -fopenmp -march=native -mtune=native -mavx -mno-avx512f")
# set(CMAKE_CXX_FLAGS "-fsanitize=address -lefence -Wall -Wextra -Wpedantic -g
# -fopenmp -march=native -mtune=native -mavx -mno-avx512f") set(CMAKE_CXX_FLAGS
# "-Wall -Wextra -Wpedantic -g -fopenmp -march=native -mtune=native -mavx
# -mno-avx512f -fno-pic -no-pie") set(CMAKE_CXX_FLAGS "-Wall -Wextra -Wpedantic
# -fopenmp -march=native -mtune=native -mavx -mno-avx512f -fno-pic -no-pie")
# set(CMAKE_CXX_FLAGS "-Wall -Wextra -Wpedantic -funroll-loops -fopenmp
# -march=native -mtune=native -mavx -mno-avx512f -fno-pic -no-pie")
# set(CMAKE_CXX_FLAGS "-Wall -Wextra -Wpedantic -O3 -fopenmp -march=native
# -mtune=native -mavx -mno-avx512f -fno-pic -no-pie")

# add debug to allow 'callgrind'
set(CMAKE_CXX_FLAGS
    "-Wall -Wextra -Wpedantic -O3 -fopenmp -march=znver2 -mtune=znver2 -mavx -mno-avx512f -g "
)

add_subdirectory(src)

set(DCMAKE_EXPORT_COMPILE_COMMANDS 1)
