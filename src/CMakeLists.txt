SET( EXE_NAME dgemm )

add_executable( ${EXE_NAME}
    calc_speed_up.cpp
    check.cpp
    dgemm_avx256.cpp
	#    dgemm_avx512.cpp
	#    dgemm_blocked.cpp
	#dgemm_unrolled.cpp
    dgemm_basic.cpp
    dgemm_basic_blocked.cpp
	#dgemm_openmp.cpp
    get_timestamp.cpp
    main.cpp
    mtx.cpp
)

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

#set_target_properties(${EXE_NAME}.s PROPERTIES COMPILE_FLAGS "-S -fverbose-asm")
# https://stackoverflow.com/questions/40329823/cmake-generate-assembly-file-then-compile-it-into-executable
set_target_properties(${EXE_NAME} PROPERTIES COMPILE_FLAGS "-save-temps -masm=intel -fverbose-asm")
