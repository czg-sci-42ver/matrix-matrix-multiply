SET( EXE_NAME dgemm )
# https://stackoverflow.com/questions/31037882/whats-the-cmake-syntax-to-set-and-use-variables
SET(CPP_FILES 
    "calc_speed_up.cpp"
    "check.cpp"
    "dgemm_avx256.cpp" 
	#    dgemm_avx512.cpp
	#    dgemm_blocked.cpp
	#dgemm_unrolled.cpp
    dgemm_unrolled_avx256.cpp
    dgemm_basic.cpp
    dgemm_basic_blocked.cpp
	#dgemm_openmp.cpp
    get_timestamp.cpp
    mtx.cpp
)
file (GLOB_RECURSE MAIN_FILES CONFIGURE_DEPENDS "main*.cpp")
# string(REPLACE "cpp" "" MAIN_EXE ${MAIN_FILES})
set(MAIN_EXE ${MAIN_FILES})
# https://stackoverflow.com/questions/50284283/cmake-file-command-gives-invalid-escape-sequence-for-regex-rule
list(TRANSFORM MAIN_EXE REPLACE "[a-z.\\/\\-]*\\/(.*)\\.cpp" "\\1")
# foreach(MAIN_FILE ${MAIN_FILES})
#     string(REGEX MATCH "[a-z.\\/\\-]*\\/(.*)\\.cpp" TMP ${MAIN_FILE})
#     message(STATUS "find: ${TMP}")
# endforeach()

# foreach (_headerFile ${MAIN_FILES})

message(STATUS "dir:${CMAKE_CURRENT_SOURCE_DIR}; cppfiles: ${CPP_FILES};\nmain_exe:${MAIN_EXE} ; ${MAIN_FILES}")

# foreach https://stackoverflow.com/questions/6921695/how-can-i-build-a-c-project-with-multiple-interdependent-subdirectories
# https://stackoverflow.com/questions/35072473/executing-bash-commands-from-a-cmake-file
execute_process (
	# use style.clang-format, affter formatting, the file will weirdly be changed...
	#COMMAND bash -c "pwd;for i in $(ls ../src | grep '.*.[cpp|h]'); do clang-format -i ../src/$i --style=file:${CMAKE_CURRENT_SOURCE_DIR}/style.clang-format;done"
	# https://clang.llvm.org/docs/ClangFormatStyleOptions.html
	# https://stackoverflow.com/questions/46996313/how-to-make-clang-format-indent-all-detail-namespaces-by-one and https://stackoverflow.com/questions/29198963/how-can-i-tell-clang-format-to-indent-visibility-modifiers ; https://stackoverflow.com/questions/42799183/how-to-auto-indent-a-c-class-with-4-spaces-using-clang-format
	COMMAND bash -c "pwd;for i in $(ls ../src | grep '.*.[cpp|h]'); do clang-format -i ../src/$i --style='{BasedOnStyle: LLVM,IndentWidth: 4,NamespaceIndentation: All,IndentAccessModifiers : true}';done"
    OUTPUT_VARIABLE outVar
)

add_executable( ${EXE_NAME}
	${CPP_FILES}
    main.cpp
)

# https://stackoverflow.com/questions/7932205/parallel-iteration-over-lists-in-makefile-or-cmake-file
list(LENGTH MAIN_FILES len_orig)
math(EXPR len_index "${len_orig}-1")
foreach(val RANGE ${len_index})
    list(GET MAIN_FILES ${val} target_file)
    list(GET MAIN_EXE ${val} target)
    add_executable( ${target}
	${CPP_FILES}
    ${target_file}
    )
endforeach()

#set_target_properties(${EXE_NAME}.s PROPERTIES COMPILE_FLAGS "-S -fverbose-asm")
# https://stackoverflow.com/questions/40329823/cmake-generate-assembly-file-then-compile-it-into-executable
set_target_properties(${EXE_NAME} PROPERTIES COMPILE_FLAGS "-save-temps -masm=intel -fverbose-asm")

#add_executable( ${EXE_NAME}.s
#    calc_speed_up.cpp
#    check.cpp
#    dgemm_avx256.cpp
#	#    dgemm_avx512.cpp
#	#    dgemm_blocked.cpp
#	#dgemm_unrolled.cpp
#    dgemm_basic.cpp
#    dgemm_basic_blocked.cpp
#	#dgemm_openmp.cpp
#    get_timestamp.cpp
#    main.cpp
#    mtx.cpp
#)
