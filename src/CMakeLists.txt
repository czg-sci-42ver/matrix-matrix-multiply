enable_language(ASM)
# set(DCMAKE_EXPORT_COMPILE_COMMANDS 1)
set(BLOCK_DENOMINATOR_LIST
    1
    2
    4
    5
    10
    20
    40)
set(EXE_NAME dgemm)
# https://stackoverflow.com/questions/31037882/whats-the-cmake-syntax-to-set-and-use-variables
file(
  GLOB_RECURSE AVX256_FILES FOLLOW_SYMLINKS
  LIST_DIRECTORIES false
  RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
  CONFIGURE_DEPENDS "[^main]*256.cpp")
message(STATUS "avx256_files: ${AVX256_FILES}")
file(
  GLOB CPP_FILES
  RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
  CONFIGURE_DEPENDS "*.cpp")
# message(STATUS "base cpp files: ${CPP_FILES}")
list(REMOVE_ITEM CPP_FILES CONFIGURE_DEPENDS "main.cpp")
message(STATUS "base cpp files: ${CPP_FILES}")
# set(CPP_FILES ${MAIN_FILES})
file(GLOB_RECURSE MAIN_FILES CONFIGURE_DEPENDS "main*.cpp")
# string(REPLACE "cpp" "" MAIN_EXE ${MAIN_FILES})
set(MAIN_EXE ${MAIN_FILES})
# https://stackoverflow.com/questions/50284283/cmake-file-command-gives-invalid-escape-sequence-for-regex-rule
list(TRANSFORM MAIN_EXE REPLACE "[a-z.\\/\\-]*\\/(.*)\\.cpp" "\\1")
# foreach(MAIN_FILE ${MAIN_FILES}) string(REGEX MATCH
# "[a-z.\\/\\-]*\\/(.*)\\.cpp" TMP ${MAIN_FILE}) message(STATUS "find: ${TMP}")
# endforeach()

# foreach (_headerFile ${MAIN_FILES})

message(
  STATUS
    "dir:${CMAKE_CURRENT_SOURCE_DIR}; cppfiles: ${CPP_FILES};\nmain_exe:${MAIN_EXE} ; ${MAIN_FILES}"
)

# foreach
# https://stackoverflow.com/questions/6921695/how-can-i-build-a-c-project-with-multiple-interdependent-subdirectories
# https://stackoverflow.com/questions/35072473/executing-bash-commands-from-a-cmake-file
execute_process(
  # use style.clang-format, affter formatting, the file will weirdly be
  # changed... COMMAND bash -c "pwd;for i in $(ls ../src | grep '.*.[cpp|h]');
  # do clang-format -i ../src/$i
  # --style=file:${CMAKE_CURRENT_SOURCE_DIR}/style.clang-format;done"
  # https://clang.llvm.org/docs/ClangFormatStyleOptions.html
  # https://stackoverflow.com/questions/46996313/how-to-make-clang-format-indent-all-detail-namespaces-by-one
  # and
  # https://stackoverflow.com/questions/29198963/how-can-i-tell-clang-format-to-indent-visibility-modifiers
  # ;
  # https://stackoverflow.com/questions/42799183/how-to-auto-indent-a-c-class-with-4-spaces-using-clang-format
  COMMAND
    bash -c
    "for i in $(ls ../src | grep '.*.[cpp|h]'); do clang-format -i ../src/$i --style='{BasedOnStyle: LLVM,IndentWidth: 4,NamespaceIndentation: All,IndentAccessModifiers : true}';done"
  COMMAND
    bash -c
    "for i in $(find .. -name 'CMakeLists.txt');do cmake-format -i $i;done"
    COMMAND_ECHO STDOUT
  OUTPUT_VARIABLE outVar)

# add_executable( ${EXE_NAME}.s ${CPP_FILES} main.cpp ) #
# set_target_properties(${EXE_NAME}.s PROPERTIES COMPILE_FLAGS "-Wall -Wextra
# -Wpedantic -O3 -fopenmp -march=znver2 -mtune=znver2 -mavx -mno-avx512f -g -S
# -masm=intel -fverbose-asm") set_target_properties(${EXE_NAME}.s PROPERTIES
# COMPILE_FLAGS "-S")

add_executable(${EXE_NAME} ${CPP_FILES} main.cpp)

# https://stackoverflow.com/questions/7932205/parallel-iteration-over-lists-in-makefile-or-cmake-file
list(LENGTH MAIN_FILES len_orig)
math(EXPR len_index "${len_orig}-1")
foreach(val RANGE ${len_index})
  list(GET MAIN_FILES ${val} target_file)
  list(GET MAIN_EXE ${val} target)
  #[[
  not use multiple independent main_{foo}.cpp because main.cpp can be got func perf by `perf report/annotate`
  .]]
  # add_executable(${target} ${CPP_FILES} ${target_file})
endforeach()

foreach(BLOCK_DENOMINATOR ${BLOCK_DENOMINATOR_LIST})
  add_executable(# "debug_block/${EXE_NAME}_${BLOCK_DENOMINATOR}"
                 "${EXE_NAME}_${BLOCK_DENOMINATOR}" ${CPP_FILES} main.cpp)
  # ############################################################################
  # CMAKE_BINARY_DIR
  # https://stackoverflow.com/questions/59131118/how-do-i-get-the-output-path-for-a-cmake-project
  # ;
  # https://stackoverflow.com/questions/13556885/how-to-change-the-executable-output-directory-for-win32-builds-in-cmake
  # ############################################################################
  # add_custom_command to do some extra things
  # https://stackoverflow.com/questions/74041614/cmake-how-to-get-binary-target-complete-directory-and-name-on-windows
  set_target_properties(
    ${EXE_NAME}_${BLOCK_DENOMINATOR} PROPERTIES RUNTIME_OUTPUT_DIRECTORY
                                                ${CMAKE_BINARY_DIR}/debug_block)
  set_target_properties(
    ${EXE_NAME}_${BLOCK_DENOMINATOR}
    PROPERTIES COMPILE_FLAGS
               "${CMAKE_CXX_FLAGS} -DBLOCK_DENOMINATOR=${BLOCK_DENOMINATOR}")
endforeach()

# set_target_properties(${EXE_NAME}.s PROPERTIES COMPILE_FLAGS "-S
# -fverbose-asm")
# https://stackoverflow.com/questions/40329823/cmake-generate-assembly-file-then-compile-it-into-executable
# get_target_property(EXE_NAME_PROPERTY ${EXE_NAME} COMPILE_OPTIONS)
# message(STATUS "before change, COMPILE_FLAGS: ${EXE_NAME_PROPERTY}")

#[[
1. multiple files generate multiple `.s` and won't has one whole `.s` as objdump shows.
use `EXE_NAME=dgemm;g++ -Wall -Wextra -Wpedantic -O3 -fopenmp -march=znver2 -mtune=znver2 -mavx -mno-avx512f -g -masm=intel -S ../src/calc_speed_up.cpp ../src/check.cpp ../src/dgemm_avx256.cpp ../src/dgemm_unrolled_avx256.cpp ../src/dgemm_basic.cpp ../src/dgemm_basic_blocked.cpp ../src/get_timestamp.cpp ../src/mtx.cpp ../src/main.cpp --verbose` to test
also see this figure https://www.dartmouth.edu/~rc/classes/softdev_linux/complex_compile.html
2. `-alhnd=` see https://www.systutorials.com/generate-a-mixed-source-and-assembly-listing-using-gcc/ from https://stackoverflow.com/questions/137038/how-do-you-get-assembler-output-from-c-c-source-in-gcc/137479#comment64507308_137479; also see https://intellij-support.jetbrains.com/hc/en-us/community/posts/360000094744-Generating-assembly-code
3. TODO add_custom_target usage https://gist.github.com/socantre/7ee63133a0a3a08f3990
4. in new cmake, `make help` seems no `.s` https://cmake.org/pipermail/cmake/2012-October/052427.html
5. `target_compile_options` and `COMPILE_FLAGS` diff https://stackoverflow.com/questions/24302073/difference-between-compile-flags-and-compile-options
.]]
set(EXE_NAME_FLAG ${CMAKE_CXX_FLAGS})
# set(UNROLL TRUE)
# https://stackoverflow.com/questions/18001198/how-do-you-concatenate-string-in-cmake
string(APPEND EXE_NAME_FLAG " -save-temps -masm=intel -fverbose-asm")
set(EXE_NAME_FLAG_NO_INLINE_UNROLL ${EXE_NAME_FLAG})
#[[
see https://stackoverflow.com/questions/39478171/loop-unrolling-behaviour-in-gcc; "-fno-move-loop-invariants..." in https://linux-il.linux.org.il.narkive.com/8SnKn2yZ/disabling-loop-unrolling-in-gcc ; maybe also "#pragma GCC push_options" https://www.mersenneforum.org/showthread.php?t=22306
.]]
# string(APPEND EXE_NAME_FLAG_NO_INLINE_UNROLL " -fno-inline-small-functions
# -fno-inline -fno-unroll-loops -fno-peel-loops -fno-inline-functions") # this
# will fail
string(APPEND EXE_NAME_FLAG_NO_INLINE_UNROLL
       " -fno-unroll-loops -fno-peel-loops")
message(STATUS "after assignment, COMPILE_FLAGS: ${EXE_NAME_FLAG}")
if(UNROLL)
  set_target_properties(
    ${EXE_NAME} PROPERTIES COMPILE_FLAGS ${EXE_NAME_FLAG_NO_INLINE_UNROLL})
else()
  set_target_properties(${EXE_NAME} PROPERTIES COMPILE_FLAGS ${EXE_NAME_FLAG})
endif()
# set_target_properties(${EXE_NAME} PROPERTIES COMPILE_FLAGS "-Wall -Wextra
# -Wpedantic -O3 -fopenmp -march=znver2 -mtune=znver2 -mavx -mno-avx512f -g
# -save-temps -masm=intel -fverbose-asm -Wa,-alhnd=${EXE_NAME}.s")
get_target_property(EXE_NAME_PROPERTY ${EXE_NAME} COMPILE_FLAGS)
message(STATUS "after change, COMPILE_FLAGS: ${EXE_NAME_PROPERTY}")

# add_executable( ${EXE_NAME}.s ${CPP_FILES} main.cpp )
# set_target_properties(${EXE_NAME}.s PROPERTIES COMPILE_FLAGS "-Wall -Wextra
# -Wpedantic -O3 -fopenmp -march=znver2 -mtune=znver2 -mavx -mno-avx512f -g -S
# -masm=intel -fverbose-asm")

# add_executable( ${EXE_NAME}.s calc_speed_up.cpp check.cpp dgemm_avx256.cpp #
# dgemm_avx512.cpp #    dgemm_blocked.cpp #dgemm_unrolled.cpp dgemm_basic.cpp
# dgemm_basic_blocked.cpp #dgemm_openmp.cpp get_timestamp.cpp main.cpp mtx.cpp )
