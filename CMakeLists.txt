cmake_minimum_required( VERSION 3.0 )

project( dgemm )

set( CMAKE_CXX_STANDARD 17 )
set( CMAKE_CXX_STANDARD_REQUIRED ON )
set( CMAKE_CXX_EXTENSIONS OFF )
set( CMAKE_BUILD_TYPE Release )

#set(CMAKE_CXX_FLAGS "-static-libasan -fsanitize=address -lefence -Wall -Wextra -Wpedantic -g -fopenmp -march=native -mtune=native -mavx -mno-avx512f")
#set(CMAKE_CXX_FLAGS "-fsanitize=address -lefence -Wall -Wextra -Wpedantic -g -fopenmp -march=native -mtune=native -mavx -mno-avx512f")
set(CMAKE_CXX_FLAGS "-Wall -Wextra -Wpedantic -g -fopenmp -march=native -mtune=native -mavx -mno-avx512f -fno-pic -no-pie")

add_subdirectory(src)

set(DCMAKE_EXPORT_COMPILE_COMMANDS 1)
