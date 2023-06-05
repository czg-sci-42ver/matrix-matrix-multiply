	.file	"dgemm_avx256.cpp"
	.intel_syntax noprefix
# GNU C++17 (GCC) version 13.1.1 20230429 (x86_64-pc-linux-gnu)
#	compiled by GNU C version 13.1.1 20230429, GMP version 6.2.1, MPFR version 4.2.0, MPC version 1.3.1, isl version isl-0.26-GMP

# warning: MPFR header version 4.2.0 differs from library version 4.2.0-p9.
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -march=znver2 -mmmx -mpopcnt -msse -msse2 -msse3 -mssse3 -msse4.1 -msse4.2 -mavx -mavx2 -msse4a -mno-fma4 -mno-xop -mfma -mno-avx512f -mbmi -mbmi2 -maes -mpclmul -mno-avx512vl -mno-avx512bw -mno-avx512dq -mno-avx512cd -mno-avx512er -mno-avx512pf -mno-avx512vbmi -mno-avx512ifma -mno-avx5124vnniw -mno-avx5124fmaps -mno-avx512vpopcntdq -mno-avx512vbmi2 -mno-gfni -mno-vpclmulqdq -mno-avx512vnni -mno-avx512bitalg -mno-avx512bf16 -mno-avx512vp2intersect -mno-3dnow -madx -mabm -mno-cldemote -mclflushopt -mclwb -mclzero -mcx16 -mno-enqcmd -mf16c -mfsgsbase -mfxsr -mno-hle -msahf -mno-lwp -mlzcnt -mmovbe -mno-movdir64b -mno-movdiri -mmwaitx -mno-pconfig -mno-pku -mno-prefetchwt1 -mprfchw -mno-ptwrite -mrdpid -mrdrnd -mrdseed -mno-rtm -mno-serialize -mno-sgx -msha -mno-shstk -mno-tbm -mno-tsxldtrk -mno-vaes -mno-waitpkg -mwbnoinvd -mxsave -mxsavec -mxsaveopt -mxsaves -mno-amx-tile -mno-amx-int8 -mno-amx-bf16 -mno-uintr -mno-hreset -mno-kl -mno-widekl -mno-avxvnni -mno-avx512fp16 -mno-avxifma -mno-avxvnniint8 -mno-avxneconvert -mno-cmpccxadd -mno-amx-fp16 -mno-prefetchi -mno-raoint -mno-amx-complex --param=l1-cache-size=32 --param=l1-cache-line-size=64 --param=l2-cache-size=512 -mtune=znver2 -masm=intel -g -O3
	.text
.Ltext0:
	.file 0 "/home/czg/matrix-matrix-multiply/asm" "../src/dgemm_avx256.cpp"
	.p2align 4
	.globl	_Z12dgemm_avx256jPKdS0_Pd
	.type	_Z12dgemm_avx256jPKdS0_Pd, @function
_Z12dgemm_avx256jPKdS0_Pd:
.LVL0:
.LFB6625:
	.file 1 "../src/dgemm_avx256.cpp"
	.loc 1 26 1 view -0
	.cfi_startproc
	.loc 1 28 5 view .LVU1
.LBB18:
	.loc 1 28 28 discriminator 1 view .LVU2
	test	edi, edi	# n
	je	.L17	#,
.LBE18:
# ../src/dgemm_avx256.cpp:26: {
	.loc 1 26 1 is_stmt 0 view .LVU3
	push	rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	r9, rsi	# A, tmp122
	mov	rbp, rsp	#,
	.cfi_def_cfa_register 6
	push	r15	#
	.cfi_offset 15, -24
	xor	r15d, r15d	# i
	push	r14	#
	.cfi_offset 14, -32
	mov	r14d, edi	# n, n
	push	r13	#
	.cfi_offset 13, -40
	mov	r13, rcx	# C, tmp124
	push	r12	#
	.cfi_offset 12, -48
	mov	r12, rdx	# B, tmp123
	push	rbx	#
	.cfi_offset 3, -56
.LVL1:
	.p2align 4
	.p2align 3
.L2:
.LBB42:
.LBB19:
	.loc 1 30 32 is_stmt 1 discriminator 1 view .LVU4
.LBB20:
# ../src/dgemm_avx256.cpp:32:             __m256d c0 = _mm256_load_pd(C + i + j * n); /* c0 = C[i][j] */
	.loc 1 32 47 is_stmt 0 view .LVU5
	mov	esi, r15d	# _60, i
	xor	r10d, r10d	# ivtmp.20
.LBE20:
# ../src/dgemm_avx256.cpp:30:         for( uint32_t j = 0; j < n; j++ ) 
	.loc 1 30 23 view .LVU6
	xor	ebx, ebx	# j
.LVL2:
	.p2align 4
	.p2align 3
.L5:
.LBB40:
	.loc 1 32 13 is_stmt 1 view .LVU7
# ../src/dgemm_avx256.cpp:32:             __m256d c0 = _mm256_load_pd(C + i + j * n); /* c0 = C[i][j] */
	.loc 1 32 47 is_stmt 0 view .LVU8
	mov	edx, r10d	# _3, ivtmp.20
.LBB21:
.LBB22:
# /usr/lib/gcc/x86_64-pc-linux-gnu/13.1.1/include/avxintrin.h:869:   return *(__m256d *)__P;
	.file 2 "/usr/lib/gcc/x86_64-pc-linux-gnu/13.1.1/include/avxintrin.h"
	.loc 2 869 22 view .LVU9
	xor	ecx, ecx	# ivtmp.15
.LBE22:
.LBE21:
# ../src/dgemm_avx256.cpp:32:             __m256d c0 = _mm256_load_pd(C + i + j * n); /* c0 = C[i][j] */
	.loc 1 32 47 view .LVU10
	lea	rax, [rdx+rsi]	# tmp111,
	lea	r11, 0[r13+rax*8]	# _6,
.LVL3:
.LBB24:
.LBI21:
	.loc 2 867 1 is_stmt 1 view .LVU11
.LBB23:
	.loc 2 869 3 view .LVU12
	lea	rax, [r12+rdx*8]	# ivtmp.14,
	add	rdx, r14	# tmp115, n
# /usr/lib/gcc/x86_64-pc-linux-gnu/13.1.1/include/avxintrin.h:869:   return *(__m256d *)__P;
	.loc 2 869 22 is_stmt 0 view .LVU13
	vmovapd	ymm0, YMMWORD PTR [r11]	# c0, MEM[(__m256d * {ref-all})_6]
.LVL4:
	.loc 2 869 22 view .LVU14
.LBE23:
.LBE24:
	.loc 1 33 13 is_stmt 1 view .LVU15
.LBB25:
	.loc 1 33 36 discriminator 1 view .LVU16
	lea	r8, [r12+rdx*8]	# _43,
.LVL5:
	.p2align 4
	.p2align 3
.L4:
	.loc 1 35 17 view .LVU17
.LBB26:
.LBI26:
	.loc 2 734 1 view .LVU18
.LBB27:
	.loc 2 736 3 view .LVU19
.LBE27:
.LBE26:
# ../src/dgemm_avx256.cpp:36:                         _mm256_mul_pd( _mm256_load_pd(A + i + k * n), _mm256_broadcast_sd(B + k + j * n) ) );
	.loc 1 36 61 is_stmt 0 view .LVU20
	mov	edx, ecx	# ivtmp.15, ivtmp.15
.LBB29:
.LBB28:
# /usr/lib/gcc/x86_64-pc-linux-gnu/13.1.1/include/avxintrin.h:736:   return (__m256d) __builtin_ia32_vbroadcastsd256 (__X);
	.loc 2 736 10 view .LVU21
	vbroadcastsd	ymm1, QWORD PTR [rax]	# tmp117,* ivtmp.14
.LVL6:
	.loc 2 736 10 view .LVU22
.LBE28:
.LBE29:
.LBB30:
.LBI30:
	.loc 2 867 1 is_stmt 1 view .LVU23
.LBB31:
	.loc 2 869 3 view .LVU24
	.loc 2 869 3 is_stmt 0 view .LVU25
.LBE31:
.LBE30:
.LBB32:
.LBI32:
	.loc 2 141 1 is_stmt 1 view .LVU26
.LBB33:
	.loc 2 143 3 view .LVU27
.LBE33:
.LBE32:
# ../src/dgemm_avx256.cpp:33:             for( uint32_t k = 0; k < n; k++ )
	.loc 1 33 36 is_stmt 0 discriminator 1 view .LVU28
	add	rax, 8	# ivtmp.14,
	add	ecx, edi	# ivtmp.15, n
.LVL7:
# ../src/dgemm_avx256.cpp:36:                         _mm256_mul_pd( _mm256_load_pd(A + i + k * n), _mm256_broadcast_sd(B + k + j * n) ) );
	.loc 1 36 61 view .LVU29
	add	rdx, rsi	# tmp119, _60
.LVL8:
.LBB35:
.LBB34:
# /usr/lib/gcc/x86_64-pc-linux-gnu/13.1.1/include/avxintrin.h:143:   return (__m256d) ((__v4df)__A + (__v4df)__B);
	.loc 2 143 46 view .LVU30
	vfmadd231pd	ymm0, ymm1, YMMWORD PTR [r9+rdx*8]	# c0, tmp117, MEM[(__m256d * {ref-all})_15]
.LVL9:
	.loc 2 143 46 view .LVU31
.LBE34:
.LBE35:
	.loc 1 33 13 is_stmt 1 discriminator 3 view .LVU32
	.loc 1 33 36 discriminator 1 view .LVU33
	cmp	r8, rax	# _43, ivtmp.14
	jne	.L4	#,
.LBE25:
	.loc 1 39 13 view .LVU34
.LVL10:
.LBB36:
.LBI36:
	.loc 2 873 1 view .LVU35
.LBB37:
	.loc 2 875 3 view .LVU36
.LBE37:
.LBE36:
.LBE40:
# ../src/dgemm_avx256.cpp:30:         for( uint32_t j = 0; j < n; j++ ) 
	.loc 1 30 9 is_stmt 0 discriminator 2 view .LVU37
	inc	ebx	# j
.LVL11:
.LBB41:
.LBB39:
.LBB38:
# /usr/lib/gcc/x86_64-pc-linux-gnu/13.1.1/include/avxintrin.h:875:   *(__m256d *)__P = __A;
	.loc 2 875 19 view .LVU38
	vmovapd	YMMWORD PTR [r11], ymm0	# MEM[(__m256d * {ref-all})_6], c0
.LVL12:
	.loc 2 875 19 view .LVU39
.LBE38:
.LBE39:
.LBE41:
	.loc 1 30 9 is_stmt 1 discriminator 2 view .LVU40
	.loc 1 30 32 discriminator 1 view .LVU41
	add	r10d, edi	# ivtmp.20, n
	cmp	edi, ebx	# n, j
	jne	.L5	#,
.LBE19:
	.loc 1 28 5 discriminator 2 view .LVU42
# ../src/dgemm_avx256.cpp:28:     for( uint32_t i = 0; i < n; i += 4 )
	.loc 1 28 35 is_stmt 0 discriminator 2 view .LVU43
	add	r15d, 4	# i,
.LVL13:
	.loc 1 28 28 is_stmt 1 discriminator 1 view .LVU44
	cmp	r15d, edi	# i, n
	jb	.L2	#,
	vzeroupper
.LVL14:
.LBE42:
# ../src/dgemm_avx256.cpp:42: }
	.loc 1 42 1 is_stmt 0 view .LVU45
	pop	rbx	#
.LVL15:
	.loc 1 42 1 view .LVU46
	pop	r12	#
.LVL16:
	.loc 1 42 1 view .LVU47
	pop	r13	#
.LVL17:
	.loc 1 42 1 view .LVU48
	pop	r14	#
	pop	r15	#
.LVL18:
	.loc 1 42 1 view .LVU49
	pop	rbp	#
	.cfi_def_cfa 7, 8
	ret	
.LVL19:
.L17:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	.loc 1 42 1 view .LVU50
	ret	
	.cfi_endproc
.LFE6625:
	.size	_Z12dgemm_avx256jPKdS0_Pd, .-_Z12dgemm_avx256jPKdS0_Pd
.Letext0:
	.file 3 "/usr/include/bits/types.h"
	.file 4 "/usr/include/bits/stdint-intn.h"
	.file 5 "/usr/include/bits/stdint-uintn.h"
	.file 6 "/usr/include/stdint.h"
	.file 7 "/usr/include/c++/13.1.1/cstdint"
	.file 8 "/usr/include/c++/13.1.1/cstdlib"
	.file 9 "/usr/include/c++/13.1.1/bits/std_abs.h"
	.file 10 "/usr/lib/gcc/x86_64-pc-linux-gnu/13.1.1/include/stddef.h"
	.file 11 "/usr/include/stdlib.h"
	.file 12 "/usr/include/bits/stdlib-float.h"
	.file 13 "/usr/include/bits/stdlib-bsearch.h"
	.file 14 "/usr/include/c++/13.1.1/stdlib.h"
	.file 15 "/usr/include/c++/13.1.1/x86_64-pc-linux-gnu/bits/c++config.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0xd8a
	.value	0x5
	.byte	0x1
	.byte	0x8
	.long	.Ldebug_abbrev0
	.uleb128 0x19
	.long	.LASF122
	.byte	0x21
	.long	.LASF0
	.long	.LASF1
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.long	.Ldebug_line0
	.uleb128 0x4
	.byte	0x1
	.byte	0x8
	.long	.LASF2
	.uleb128 0x4
	.byte	0x2
	.byte	0x7
	.long	.LASF3
	.uleb128 0x4
	.byte	0x4
	.byte	0x7
	.long	.LASF4
	.uleb128 0x4
	.byte	0x8
	.byte	0x7
	.long	.LASF5
	.uleb128 0x3
	.long	.LASF7
	.byte	0x3
	.byte	0x25
	.byte	0x15
	.long	0x56
	.uleb128 0x4
	.byte	0x1
	.byte	0x6
	.long	.LASF6
	.uleb128 0x3
	.long	.LASF8
	.byte	0x3
	.byte	0x26
	.byte	0x17
	.long	0x2e
	.uleb128 0x3
	.long	.LASF9
	.byte	0x3
	.byte	0x27
	.byte	0x1a
	.long	0x75
	.uleb128 0x4
	.byte	0x2
	.byte	0x5
	.long	.LASF10
	.uleb128 0x3
	.long	.LASF11
	.byte	0x3
	.byte	0x28
	.byte	0x1c
	.long	0x35
	.uleb128 0x3
	.long	.LASF12
	.byte	0x3
	.byte	0x29
	.byte	0x14
	.long	0x94
	.uleb128 0x1a
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x3
	.long	.LASF13
	.byte	0x3
	.byte	0x2a
	.byte	0x16
	.long	0x3c
	.uleb128 0x3
	.long	.LASF14
	.byte	0x3
	.byte	0x2c
	.byte	0x19
	.long	0xb3
	.uleb128 0x4
	.byte	0x8
	.byte	0x5
	.long	.LASF15
	.uleb128 0x3
	.long	.LASF16
	.byte	0x3
	.byte	0x2d
	.byte	0x1b
	.long	0x43
	.uleb128 0x3
	.long	.LASF17
	.byte	0x3
	.byte	0x34
	.byte	0x12
	.long	0x4a
	.uleb128 0x3
	.long	.LASF18
	.byte	0x3
	.byte	0x35
	.byte	0x13
	.long	0x5d
	.uleb128 0x3
	.long	.LASF19
	.byte	0x3
	.byte	0x36
	.byte	0x13
	.long	0x69
	.uleb128 0x3
	.long	.LASF20
	.byte	0x3
	.byte	0x37
	.byte	0x14
	.long	0x7c
	.uleb128 0x3
	.long	.LASF21
	.byte	0x3
	.byte	0x38
	.byte	0x13
	.long	0x88
	.uleb128 0x3
	.long	.LASF22
	.byte	0x3
	.byte	0x39
	.byte	0x14
	.long	0x9b
	.uleb128 0x3
	.long	.LASF23
	.byte	0x3
	.byte	0x3a
	.byte	0x13
	.long	0xa7
	.uleb128 0x3
	.long	.LASF24
	.byte	0x3
	.byte	0x3b
	.byte	0x14
	.long	0xba
	.uleb128 0x3
	.long	.LASF25
	.byte	0x3
	.byte	0x48
	.byte	0x12
	.long	0xb3
	.uleb128 0x3
	.long	.LASF26
	.byte	0x3
	.byte	0x49
	.byte	0x1b
	.long	0x43
	.uleb128 0x1b
	.byte	0x8
	.uleb128 0x6
	.long	0x145
	.uleb128 0x4
	.byte	0x1
	.byte	0x6
	.long	.LASF27
	.uleb128 0xb
	.long	0x145
	.uleb128 0x3
	.long	.LASF28
	.byte	0x4
	.byte	0x18
	.byte	0x12
	.long	0x4a
	.uleb128 0x3
	.long	.LASF29
	.byte	0x4
	.byte	0x19
	.byte	0x13
	.long	0x69
	.uleb128 0x3
	.long	.LASF30
	.byte	0x4
	.byte	0x1a
	.byte	0x13
	.long	0x88
	.uleb128 0x3
	.long	.LASF31
	.byte	0x4
	.byte	0x1b
	.byte	0x13
	.long	0xa7
	.uleb128 0x3
	.long	.LASF32
	.byte	0x5
	.byte	0x18
	.byte	0x13
	.long	0x5d
	.uleb128 0x3
	.long	.LASF33
	.byte	0x5
	.byte	0x19
	.byte	0x14
	.long	0x7c
	.uleb128 0x3
	.long	.LASF34
	.byte	0x5
	.byte	0x1a
	.byte	0x14
	.long	0x9b
	.uleb128 0xb
	.long	0x199
	.uleb128 0x3
	.long	.LASF35
	.byte	0x5
	.byte	0x1b
	.byte	0x14
	.long	0xba
	.uleb128 0x3
	.long	.LASF36
	.byte	0x6
	.byte	0x2b
	.byte	0x18
	.long	0xc6
	.uleb128 0x3
	.long	.LASF37
	.byte	0x6
	.byte	0x2c
	.byte	0x19
	.long	0xde
	.uleb128 0x3
	.long	.LASF38
	.byte	0x6
	.byte	0x2d
	.byte	0x19
	.long	0xf6
	.uleb128 0x3
	.long	.LASF39
	.byte	0x6
	.byte	0x2e
	.byte	0x19
	.long	0x10e
	.uleb128 0x3
	.long	.LASF40
	.byte	0x6
	.byte	0x31
	.byte	0x19
	.long	0xd2
	.uleb128 0x3
	.long	.LASF41
	.byte	0x6
	.byte	0x32
	.byte	0x1a
	.long	0xea
	.uleb128 0x3
	.long	.LASF42
	.byte	0x6
	.byte	0x33
	.byte	0x1a
	.long	0x102
	.uleb128 0x3
	.long	.LASF43
	.byte	0x6
	.byte	0x34
	.byte	0x1a
	.long	0x11a
	.uleb128 0x3
	.long	.LASF44
	.byte	0x6
	.byte	0x3a
	.byte	0x16
	.long	0x56
	.uleb128 0x3
	.long	.LASF45
	.byte	0x6
	.byte	0x3c
	.byte	0x13
	.long	0xb3
	.uleb128 0x3
	.long	.LASF46
	.byte	0x6
	.byte	0x3d
	.byte	0x13
	.long	0xb3
	.uleb128 0x3
	.long	.LASF47
	.byte	0x6
	.byte	0x3e
	.byte	0x13
	.long	0xb3
	.uleb128 0x3
	.long	.LASF48
	.byte	0x6
	.byte	0x47
	.byte	0x18
	.long	0x2e
	.uleb128 0x3
	.long	.LASF49
	.byte	0x6
	.byte	0x49
	.byte	0x1b
	.long	0x43
	.uleb128 0x3
	.long	.LASF50
	.byte	0x6
	.byte	0x4a
	.byte	0x1b
	.long	0x43
	.uleb128 0x3
	.long	.LASF51
	.byte	0x6
	.byte	0x4b
	.byte	0x1b
	.long	0x43
	.uleb128 0x3
	.long	.LASF52
	.byte	0x6
	.byte	0x57
	.byte	0x13
	.long	0xb3
	.uleb128 0x3
	.long	.LASF53
	.byte	0x6
	.byte	0x5a
	.byte	0x1b
	.long	0x43
	.uleb128 0x3
	.long	.LASF54
	.byte	0x6
	.byte	0x65
	.byte	0x15
	.long	0x126
	.uleb128 0x3
	.long	.LASF55
	.byte	0x6
	.byte	0x66
	.byte	0x16
	.long	0x132
	.uleb128 0x1c
	.string	"std"
	.byte	0xf
	.value	0x132
	.byte	0xb
	.long	0x556
	.uleb128 0x1
	.byte	0x7
	.byte	0x33
	.byte	0xb
	.long	0x151
	.uleb128 0x1
	.byte	0x7
	.byte	0x34
	.byte	0xb
	.long	0x15d
	.uleb128 0x1
	.byte	0x7
	.byte	0x35
	.byte	0xb
	.long	0x169
	.uleb128 0x1
	.byte	0x7
	.byte	0x36
	.byte	0xb
	.long	0x175
	.uleb128 0x1
	.byte	0x7
	.byte	0x38
	.byte	0xb
	.long	0x216
	.uleb128 0x1
	.byte	0x7
	.byte	0x39
	.byte	0xb
	.long	0x222
	.uleb128 0x1
	.byte	0x7
	.byte	0x3a
	.byte	0xb
	.long	0x22e
	.uleb128 0x1
	.byte	0x7
	.byte	0x3b
	.byte	0xb
	.long	0x23a
	.uleb128 0x1
	.byte	0x7
	.byte	0x3d
	.byte	0xb
	.long	0x1b6
	.uleb128 0x1
	.byte	0x7
	.byte	0x3e
	.byte	0xb
	.long	0x1c2
	.uleb128 0x1
	.byte	0x7
	.byte	0x3f
	.byte	0xb
	.long	0x1ce
	.uleb128 0x1
	.byte	0x7
	.byte	0x40
	.byte	0xb
	.long	0x1da
	.uleb128 0x1
	.byte	0x7
	.byte	0x42
	.byte	0xb
	.long	0x28e
	.uleb128 0x1
	.byte	0x7
	.byte	0x43
	.byte	0xb
	.long	0x276
	.uleb128 0x1
	.byte	0x7
	.byte	0x45
	.byte	0xb
	.long	0x181
	.uleb128 0x1
	.byte	0x7
	.byte	0x46
	.byte	0xb
	.long	0x18d
	.uleb128 0x1
	.byte	0x7
	.byte	0x47
	.byte	0xb
	.long	0x199
	.uleb128 0x1
	.byte	0x7
	.byte	0x48
	.byte	0xb
	.long	0x1aa
	.uleb128 0x1
	.byte	0x7
	.byte	0x4a
	.byte	0xb
	.long	0x246
	.uleb128 0x1
	.byte	0x7
	.byte	0x4b
	.byte	0xb
	.long	0x252
	.uleb128 0x1
	.byte	0x7
	.byte	0x4c
	.byte	0xb
	.long	0x25e
	.uleb128 0x1
	.byte	0x7
	.byte	0x4d
	.byte	0xb
	.long	0x26a
	.uleb128 0x1
	.byte	0x7
	.byte	0x4f
	.byte	0xb
	.long	0x1e6
	.uleb128 0x1
	.byte	0x7
	.byte	0x50
	.byte	0xb
	.long	0x1f2
	.uleb128 0x1
	.byte	0x7
	.byte	0x51
	.byte	0xb
	.long	0x1fe
	.uleb128 0x1
	.byte	0x7
	.byte	0x52
	.byte	0xb
	.long	0x20a
	.uleb128 0x1
	.byte	0x7
	.byte	0x54
	.byte	0xb
	.long	0x29a
	.uleb128 0x1
	.byte	0x7
	.byte	0x55
	.byte	0xb
	.long	0x282
	.uleb128 0x1
	.byte	0x8
	.byte	0x83
	.byte	0xb
	.long	0x5a6
	.uleb128 0x1
	.byte	0x8
	.byte	0x84
	.byte	0xb
	.long	0x5d5
	.uleb128 0x1
	.byte	0x8
	.byte	0x8a
	.byte	0xb
	.long	0x641
	.uleb128 0x1
	.byte	0x8
	.byte	0x8d
	.byte	0xb
	.long	0x65d
	.uleb128 0x1
	.byte	0x8
	.byte	0x90
	.byte	0xb
	.long	0x678
	.uleb128 0x1
	.byte	0x8
	.byte	0x91
	.byte	0xb
	.long	0x69a
	.uleb128 0x1
	.byte	0x8
	.byte	0x92
	.byte	0xb
	.long	0x6b0
	.uleb128 0x1
	.byte	0x8
	.byte	0x93
	.byte	0xb
	.long	0x6c6
	.uleb128 0x1
	.byte	0x8
	.byte	0x95
	.byte	0xb
	.long	0x6f0
	.uleb128 0x1
	.byte	0x8
	.byte	0x98
	.byte	0xb
	.long	0x70c
	.uleb128 0x1
	.byte	0x8
	.byte	0x9a
	.byte	0xb
	.long	0x722
	.uleb128 0x1
	.byte	0x8
	.byte	0x9d
	.byte	0xb
	.long	0x73d
	.uleb128 0x1
	.byte	0x8
	.byte	0x9e
	.byte	0xb
	.long	0x758
	.uleb128 0x1
	.byte	0x8
	.byte	0x9f
	.byte	0xb
	.long	0x789
	.uleb128 0x1
	.byte	0x8
	.byte	0xa1
	.byte	0xb
	.long	0x7a9
	.uleb128 0x1
	.byte	0x8
	.byte	0xa4
	.byte	0xb
	.long	0x7c9
	.uleb128 0x1
	.byte	0x8
	.byte	0xa7
	.byte	0xb
	.long	0x7dc
	.uleb128 0x1
	.byte	0x8
	.byte	0xa9
	.byte	0xb
	.long	0x7e9
	.uleb128 0x1
	.byte	0x8
	.byte	0xaa
	.byte	0xb
	.long	0x7fa
	.uleb128 0x1
	.byte	0x8
	.byte	0xab
	.byte	0xb
	.long	0x81a
	.uleb128 0x1
	.byte	0x8
	.byte	0xac
	.byte	0xb
	.long	0x83a
	.uleb128 0x1
	.byte	0x8
	.byte	0xad
	.byte	0xb
	.long	0x85a
	.uleb128 0x1
	.byte	0x8
	.byte	0xaf
	.byte	0xb
	.long	0x870
	.uleb128 0x1
	.byte	0x8
	.byte	0xb0
	.byte	0xb
	.long	0x895
	.uleb128 0x1
	.byte	0x8
	.byte	0xf4
	.byte	0x16
	.long	0x604
	.uleb128 0x1
	.byte	0x8
	.byte	0xf9
	.byte	0x16
	.long	0x8f5
	.uleb128 0x1
	.byte	0x8
	.byte	0xfa
	.byte	0x16
	.long	0x90f
	.uleb128 0x1
	.byte	0x8
	.byte	0xfc
	.byte	0x16
	.long	0x92a
	.uleb128 0x1
	.byte	0x8
	.byte	0xfd
	.byte	0x16
	.long	0x980
	.uleb128 0x1
	.byte	0x8
	.byte	0xfe
	.byte	0x16
	.long	0x940
	.uleb128 0x1
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.long	0x960
	.uleb128 0x1d
	.byte	0x8
	.value	0x100
	.byte	0x16
	.long	0x99b
	.uleb128 0x8
	.string	"abs"
	.byte	0x89
	.long	.LASF56
	.long	0x9de
	.long	0x4ac
	.uleb128 0x2
	.long	0x9de
	.byte	0
	.uleb128 0x8
	.string	"abs"
	.byte	0x55
	.long	.LASF57
	.long	0x9ed
	.long	0x4c4
	.uleb128 0x2
	.long	0x9ed
	.byte	0
	.uleb128 0x8
	.string	"abs"
	.byte	0x4f
	.long	.LASF58
	.long	0x569
	.long	0x4dc
	.uleb128 0x2
	.long	0x569
	.byte	0
	.uleb128 0x8
	.string	"abs"
	.byte	0x4b
	.long	.LASF59
	.long	0x57c
	.long	0x4f4
	.uleb128 0x2
	.long	0x57c
	.byte	0
	.uleb128 0x8
	.string	"abs"
	.byte	0x47
	.long	.LASF60
	.long	0x68e
	.long	0x50c
	.uleb128 0x2
	.long	0x68e
	.byte	0
	.uleb128 0x8
	.string	"abs"
	.byte	0x3d
	.long	.LASF61
	.long	0x562
	.long	0x524
	.uleb128 0x2
	.long	0x562
	.byte	0
	.uleb128 0x8
	.string	"abs"
	.byte	0x38
	.long	.LASF62
	.long	0xb3
	.long	0x53c
	.uleb128 0x2
	.long	0xb3
	.byte	0
	.uleb128 0x12
	.string	"div"
	.byte	0xb5
	.long	.LASF99
	.long	0x5d5
	.uleb128 0x2
	.long	0xb3
	.uleb128 0x2
	.long	0xb3
	.byte	0
	.byte	0
	.uleb128 0x3
	.long	.LASF63
	.byte	0xa
	.byte	0xd6
	.byte	0x17
	.long	0x43
	.uleb128 0x4
	.byte	0x8
	.byte	0x5
	.long	.LASF64
	.uleb128 0x4
	.byte	0x10
	.byte	0x4
	.long	.LASF65
	.uleb128 0x1e
	.long	.LASF123
	.uleb128 0x4
	.byte	0x8
	.byte	0x7
	.long	.LASF66
	.uleb128 0x4
	.byte	0x4
	.byte	0x4
	.long	.LASF67
	.uleb128 0xd
	.byte	0x8
	.byte	0x3c
	.long	.LASF70
	.long	0x5a6
	.uleb128 0xe
	.long	.LASF68
	.byte	0x3d
	.byte	0x9
	.long	0x94
	.uleb128 0xf
	.string	"rem"
	.byte	0x3e
	.byte	0x9
	.long	0x94
	.byte	0x4
	.byte	0
	.uleb128 0x3
	.long	.LASF69
	.byte	0xb
	.byte	0x3f
	.byte	0x5
	.long	0x583
	.uleb128 0xd
	.byte	0x10
	.byte	0x44
	.long	.LASF71
	.long	0x5d5
	.uleb128 0xe
	.long	.LASF68
	.byte	0x45
	.byte	0xe
	.long	0xb3
	.uleb128 0xf
	.string	"rem"
	.byte	0x46
	.byte	0xe
	.long	0xb3
	.byte	0x8
	.byte	0
	.uleb128 0x3
	.long	.LASF72
	.byte	0xb
	.byte	0x47
	.byte	0x5
	.long	0x5b2
	.uleb128 0xd
	.byte	0x10
	.byte	0x4e
	.long	.LASF73
	.long	0x604
	.uleb128 0xe
	.long	.LASF68
	.byte	0x4f
	.byte	0x13
	.long	0x562
	.uleb128 0xf
	.string	"rem"
	.byte	0x50
	.byte	0x13
	.long	0x562
	.byte	0x8
	.byte	0
	.uleb128 0x3
	.long	.LASF74
	.byte	0xb
	.byte	0x51
	.byte	0x5
	.long	0x5e1
	.uleb128 0x6
	.long	0x14c
	.uleb128 0x1f
	.long	.LASF75
	.byte	0xb
	.value	0x33d
	.byte	0xf
	.long	0x622
	.uleb128 0x6
	.long	0x627
	.uleb128 0x20
	.long	0x94
	.long	0x63b
	.uleb128 0x2
	.long	0x63b
	.uleb128 0x2
	.long	0x63b
	.byte	0
	.uleb128 0x6
	.long	0x640
	.uleb128 0x21
	.uleb128 0x5
	.long	.LASF76
	.value	0x267
	.byte	0xc
	.long	0x94
	.long	0x657
	.uleb128 0x2
	.long	0x657
	.byte	0
	.uleb128 0x6
	.long	0x65c
	.uleb128 0x22
	.uleb128 0x23
	.long	.LASF77
	.byte	0xb
	.value	0x26c
	.byte	0x12
	.long	.LASF77
	.long	0x94
	.long	0x678
	.uleb128 0x2
	.long	0x657
	.byte	0
	.uleb128 0x7
	.long	.LASF78
	.byte	0xc
	.byte	0x19
	.byte	0x1
	.long	0x68e
	.long	0x68e
	.uleb128 0x2
	.long	0x610
	.byte	0
	.uleb128 0x4
	.byte	0x8
	.byte	0x4
	.long	.LASF79
	.uleb128 0xb
	.long	0x68e
	.uleb128 0x5
	.long	.LASF80
	.value	0x16a
	.byte	0x1
	.long	0x94
	.long	0x6b0
	.uleb128 0x2
	.long	0x610
	.byte	0
	.uleb128 0x5
	.long	.LASF81
	.value	0x16f
	.byte	0x1
	.long	0xb3
	.long	0x6c6
	.uleb128 0x2
	.long	0x610
	.byte	0
	.uleb128 0x7
	.long	.LASF82
	.byte	0xd
	.byte	0x14
	.byte	0x1
	.long	0x13e
	.long	0x6f0
	.uleb128 0x2
	.long	0x63b
	.uleb128 0x2
	.long	0x63b
	.uleb128 0x2
	.long	0x556
	.uleb128 0x2
	.long	0x556
	.uleb128 0x2
	.long	0x615
	.byte	0
	.uleb128 0x24
	.string	"div"
	.byte	0xb
	.value	0x369
	.byte	0xe
	.long	0x5a6
	.long	0x70c
	.uleb128 0x2
	.long	0x94
	.uleb128 0x2
	.long	0x94
	.byte	0
	.uleb128 0x5
	.long	.LASF83
	.value	0x28e
	.byte	0xe
	.long	0x140
	.long	0x722
	.uleb128 0x2
	.long	0x610
	.byte	0
	.uleb128 0x5
	.long	.LASF84
	.value	0x36b
	.byte	0xf
	.long	0x5d5
	.long	0x73d
	.uleb128 0x2
	.long	0xb3
	.uleb128 0x2
	.long	0xb3
	.byte	0
	.uleb128 0x5
	.long	.LASF85
	.value	0x3af
	.byte	0xc
	.long	0x94
	.long	0x758
	.uleb128 0x2
	.long	0x610
	.uleb128 0x2
	.long	0x556
	.byte	0
	.uleb128 0x5
	.long	.LASF86
	.value	0x3ba
	.byte	0xf
	.long	0x556
	.long	0x778
	.uleb128 0x2
	.long	0x778
	.uleb128 0x2
	.long	0x610
	.uleb128 0x2
	.long	0x556
	.byte	0
	.uleb128 0x6
	.long	0x77d
	.uleb128 0x4
	.byte	0x4
	.byte	0x5
	.long	.LASF87
	.uleb128 0xb
	.long	0x77d
	.uleb128 0x5
	.long	.LASF88
	.value	0x3b2
	.byte	0xc
	.long	0x94
	.long	0x7a9
	.uleb128 0x2
	.long	0x778
	.uleb128 0x2
	.long	0x610
	.uleb128 0x2
	.long	0x556
	.byte	0
	.uleb128 0x13
	.long	.LASF90
	.value	0x353
	.long	0x7c9
	.uleb128 0x2
	.long	0x13e
	.uleb128 0x2
	.long	0x556
	.uleb128 0x2
	.long	0x556
	.uleb128 0x2
	.long	0x615
	.byte	0
	.uleb128 0x25
	.long	.LASF89
	.byte	0xb
	.value	0x283
	.byte	0xd
	.long	0x7dc
	.uleb128 0x2
	.long	0x94
	.byte	0
	.uleb128 0x26
	.long	.LASF124
	.byte	0xb
	.value	0x1c6
	.byte	0xc
	.long	0x94
	.uleb128 0x13
	.long	.LASF91
	.value	0x1c8
	.long	0x7fa
	.uleb128 0x2
	.long	0x3c
	.byte	0
	.uleb128 0x7
	.long	.LASF92
	.byte	0xb
	.byte	0x76
	.byte	0xf
	.long	0x68e
	.long	0x815
	.uleb128 0x2
	.long	0x610
	.uleb128 0x2
	.long	0x815
	.byte	0
	.uleb128 0x6
	.long	0x140
	.uleb128 0x7
	.long	.LASF93
	.byte	0xb
	.byte	0xb1
	.byte	0x11
	.long	0xb3
	.long	0x83a
	.uleb128 0x2
	.long	0x610
	.uleb128 0x2
	.long	0x815
	.uleb128 0x2
	.long	0x94
	.byte	0
	.uleb128 0x7
	.long	.LASF94
	.byte	0xb
	.byte	0xb5
	.byte	0x1a
	.long	0x43
	.long	0x85a
	.uleb128 0x2
	.long	0x610
	.uleb128 0x2
	.long	0x815
	.uleb128 0x2
	.long	0x94
	.byte	0
	.uleb128 0x5
	.long	.LASF95
	.value	0x324
	.byte	0xc
	.long	0x94
	.long	0x870
	.uleb128 0x2
	.long	0x610
	.byte	0
	.uleb128 0x5
	.long	.LASF96
	.value	0x3be
	.byte	0xf
	.long	0x556
	.long	0x890
	.uleb128 0x2
	.long	0x140
	.uleb128 0x2
	.long	0x890
	.uleb128 0x2
	.long	0x556
	.byte	0
	.uleb128 0x6
	.long	0x784
	.uleb128 0x5
	.long	.LASF97
	.value	0x3b6
	.byte	0xc
	.long	0x94
	.long	0x8b0
	.uleb128 0x2
	.long	0x140
	.uleb128 0x2
	.long	0x77d
	.byte	0
	.uleb128 0x27
	.long	.LASF98
	.byte	0xf
	.value	0x157
	.byte	0xb
	.long	0x90f
	.uleb128 0x1
	.byte	0x8
	.byte	0xcc
	.byte	0xb
	.long	0x604
	.uleb128 0x1
	.byte	0x8
	.byte	0xdc
	.byte	0xb
	.long	0x90f
	.uleb128 0x1
	.byte	0x8
	.byte	0xe7
	.byte	0xb
	.long	0x92a
	.uleb128 0x1
	.byte	0x8
	.byte	0xe8
	.byte	0xb
	.long	0x940
	.uleb128 0x1
	.byte	0x8
	.byte	0xe9
	.byte	0xb
	.long	0x960
	.uleb128 0x1
	.byte	0x8
	.byte	0xeb
	.byte	0xb
	.long	0x980
	.uleb128 0x1
	.byte	0x8
	.byte	0xec
	.byte	0xb
	.long	0x99b
	.uleb128 0x12
	.string	"div"
	.byte	0xd9
	.long	.LASF100
	.long	0x604
	.uleb128 0x2
	.long	0x562
	.uleb128 0x2
	.long	0x562
	.byte	0
	.byte	0
	.uleb128 0x5
	.long	.LASF101
	.value	0x36f
	.byte	0x1e
	.long	0x604
	.long	0x92a
	.uleb128 0x2
	.long	0x562
	.uleb128 0x2
	.long	0x562
	.byte	0
	.uleb128 0x5
	.long	.LASF102
	.value	0x176
	.byte	0x1
	.long	0x562
	.long	0x940
	.uleb128 0x2
	.long	0x610
	.byte	0
	.uleb128 0x7
	.long	.LASF103
	.byte	0xb
	.byte	0xc9
	.byte	0x16
	.long	0x562
	.long	0x960
	.uleb128 0x2
	.long	0x610
	.uleb128 0x2
	.long	0x815
	.uleb128 0x2
	.long	0x94
	.byte	0
	.uleb128 0x7
	.long	.LASF104
	.byte	0xb
	.byte	0xce
	.byte	0x1f
	.long	0x575
	.long	0x980
	.uleb128 0x2
	.long	0x610
	.uleb128 0x2
	.long	0x815
	.uleb128 0x2
	.long	0x94
	.byte	0
	.uleb128 0x7
	.long	.LASF105
	.byte	0xb
	.byte	0x7c
	.byte	0xe
	.long	0x57c
	.long	0x99b
	.uleb128 0x2
	.long	0x610
	.uleb128 0x2
	.long	0x815
	.byte	0
	.uleb128 0x7
	.long	.LASF106
	.byte	0xb
	.byte	0x7f
	.byte	0x14
	.long	0x569
	.long	0x9b6
	.uleb128 0x2
	.long	0x610
	.uleb128 0x2
	.long	0x815
	.byte	0
	.uleb128 0x1
	.byte	0xe
	.byte	0x27
	.byte	0xc
	.long	0x641
	.uleb128 0x1
	.byte	0xe
	.byte	0x2b
	.byte	0xe
	.long	0x65d
	.uleb128 0x1
	.byte	0xe
	.byte	0x2e
	.byte	0xe
	.long	0x7c9
	.uleb128 0x1
	.byte	0xe
	.byte	0x36
	.byte	0xc
	.long	0x5a6
	.uleb128 0x1
	.byte	0xe
	.byte	0x37
	.byte	0xc
	.long	0x5d5
	.uleb128 0x4
	.byte	0x10
	.byte	0x4
	.long	.LASF107
	.uleb128 0x1
	.byte	0xe
	.byte	0x39
	.byte	0xc
	.long	0x494
	.uleb128 0x4
	.byte	0x10
	.byte	0x5
	.long	.LASF108
	.uleb128 0x1
	.byte	0xe
	.byte	0x39
	.byte	0xc
	.long	0x4ac
	.uleb128 0x1
	.byte	0xe
	.byte	0x39
	.byte	0xc
	.long	0x4c4
	.uleb128 0x1
	.byte	0xe
	.byte	0x39
	.byte	0xc
	.long	0x4dc
	.uleb128 0x1
	.byte	0xe
	.byte	0x39
	.byte	0xc
	.long	0x4f4
	.uleb128 0x1
	.byte	0xe
	.byte	0x39
	.byte	0xc
	.long	0x50c
	.uleb128 0x1
	.byte	0xe
	.byte	0x39
	.byte	0xc
	.long	0x524
	.uleb128 0x1
	.byte	0xe
	.byte	0x3a
	.byte	0xc
	.long	0x678
	.uleb128 0x1
	.byte	0xe
	.byte	0x3b
	.byte	0xc
	.long	0x69a
	.uleb128 0x1
	.byte	0xe
	.byte	0x3c
	.byte	0xc
	.long	0x6b0
	.uleb128 0x1
	.byte	0xe
	.byte	0x3d
	.byte	0xc
	.long	0x6c6
	.uleb128 0x1
	.byte	0xe
	.byte	0x3f
	.byte	0xc
	.long	0x8f5
	.uleb128 0x1
	.byte	0xe
	.byte	0x3f
	.byte	0xc
	.long	0x53c
	.uleb128 0x1
	.byte	0xe
	.byte	0x3f
	.byte	0xc
	.long	0x6f0
	.uleb128 0x1
	.byte	0xe
	.byte	0x41
	.byte	0xc
	.long	0x70c
	.uleb128 0x1
	.byte	0xe
	.byte	0x43
	.byte	0xc
	.long	0x722
	.uleb128 0x1
	.byte	0xe
	.byte	0x46
	.byte	0xc
	.long	0x73d
	.uleb128 0x1
	.byte	0xe
	.byte	0x47
	.byte	0xc
	.long	0x758
	.uleb128 0x1
	.byte	0xe
	.byte	0x48
	.byte	0xc
	.long	0x789
	.uleb128 0x1
	.byte	0xe
	.byte	0x4a
	.byte	0xc
	.long	0x7a9
	.uleb128 0x1
	.byte	0xe
	.byte	0x4b
	.byte	0xc
	.long	0x7dc
	.uleb128 0x1
	.byte	0xe
	.byte	0x4d
	.byte	0xc
	.long	0x7e9
	.uleb128 0x1
	.byte	0xe
	.byte	0x4e
	.byte	0xc
	.long	0x7fa
	.uleb128 0x1
	.byte	0xe
	.byte	0x4f
	.byte	0xc
	.long	0x81a
	.uleb128 0x1
	.byte	0xe
	.byte	0x50
	.byte	0xc
	.long	0x83a
	.uleb128 0x1
	.byte	0xe
	.byte	0x51
	.byte	0xc
	.long	0x85a
	.uleb128 0x1
	.byte	0xe
	.byte	0x53
	.byte	0xc
	.long	0x870
	.uleb128 0x1
	.byte	0xe
	.byte	0x54
	.byte	0xc
	.long	0x895
	.uleb128 0x3
	.long	.LASF109
	.byte	0x2
	.byte	0x29
	.byte	0x10
	.long	0xad8
	.uleb128 0x14
	.long	0x68e
	.long	0xae3
	.uleb128 0x15
	.byte	0
	.uleb128 0x3
	.long	.LASF110
	.byte	0x2
	.byte	0x3b
	.byte	0x10
	.long	0xaef
	.uleb128 0x14
	.long	0x68e
	.long	0xafa
	.uleb128 0x15
	.byte	0
	.uleb128 0x4
	.byte	0x2
	.byte	0x4
	.long	.LASF111
	.uleb128 0x4
	.byte	0x2
	.byte	0x4
	.long	.LASF112
	.uleb128 0x28
	.long	.LASF125
	.byte	0x1
	.byte	0x19
	.byte	0x6
	.long	.LASF126
	.quad	.LFB6625
	.quad	.LFE6625-.LFB6625
	.uleb128 0x1
	.byte	0x9c
	.long	0xcc4
	.uleb128 0x29
	.string	"n"
	.byte	0x1
	.byte	0x19
	.byte	0x22
	.long	0x1a5
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x10
	.string	"A"
	.byte	0x33
	.long	0xcc4
	.long	.LLST0
	.long	.LVUS0
	.uleb128 0x10
	.string	"B"
	.byte	0x44
	.long	0xcc4
	.long	.LLST1
	.long	.LVUS1
	.uleb128 0x10
	.string	"C"
	.byte	0x4f
	.long	0xcc9
	.long	.LLST2
	.long	.LVUS2
	.uleb128 0x2a
	.long	.LLRL3
	.long	0xcb8
	.uleb128 0xc
	.string	"i"
	.byte	0x1c
	.byte	0x13
	.long	0x199
	.long	.LLST4
	.long	.LVUS4
	.uleb128 0x2b
	.quad	.LBB19
	.quad	.LBE19-.LBB19
	.uleb128 0xc
	.string	"j"
	.byte	0x1e
	.byte	0x17
	.long	0x199
	.long	.LLST5
	.long	.LVUS5
	.uleb128 0x2c
	.long	.LLRL6
	.uleb128 0xc
	.string	"c0"
	.byte	0x20
	.byte	0x15
	.long	0xae3
	.long	.LLST7
	.long	.LVUS7
	.uleb128 0x2d
	.quad	.LBB25
	.quad	.LBE25-.LBB25
	.long	0xc60
	.uleb128 0xc
	.string	"k"
	.byte	0x21
	.byte	0x1b
	.long	0x199
	.long	.LLST10
	.long	.LVUS10
	.uleb128 0x16
	.long	0xd19
	.quad	.LBI26
	.byte	.LVU18
	.long	.LLRL11
	.byte	0x23
	.byte	0x23
	.long	0xc05
	.uleb128 0x9
	.long	0xd2c
	.long	.LLST12
	.long	.LVUS12
	.byte	0
	.uleb128 0x2e
	.long	0xcf9
	.quad	.LBI30
	.byte	.LVU23
	.quad	.LBB30
	.quad	.LBE30-.LBB30
	.byte	0x1
	.byte	0x23
	.byte	0x23
	.long	0xc38
	.uleb128 0x9
	.long	0xd0c
	.long	.LLST13
	.long	.LVUS13
	.byte	0
	.uleb128 0x17
	.long	0xd65
	.quad	.LBI32
	.byte	.LVU26
	.long	.LLRL14
	.byte	0x23
	.byte	0x23
	.uleb128 0x2f
	.long	0xd81
	.uleb128 0x9
	.long	0xd76
	.long	.LLST15
	.long	.LVUS15
	.byte	0
	.byte	0
	.uleb128 0x16
	.long	0xcf9
	.quad	.LBI21
	.byte	.LVU11
	.long	.LLRL8
	.byte	0x20
	.byte	0x28
	.long	0xc86
	.uleb128 0x9
	.long	0xd0c
	.long	.LLST9
	.long	.LVUS9
	.byte	0
	.uleb128 0x17
	.long	0xcce
	.quad	.LBI36
	.byte	.LVU35
	.long	.LLRL16
	.byte	0x27
	.byte	0x1c
	.uleb128 0x9
	.long	0xcec
	.long	.LLST17
	.long	.LVUS17
	.uleb128 0x9
	.long	0xce0
	.long	.LLST18
	.long	.LVUS18
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x30
	.quad	.LVL14
	.uleb128 0x1
	.byte	0x30
	.byte	0
	.uleb128 0x6
	.long	0x695
	.uleb128 0x6
	.long	0x68e
	.uleb128 0x31
	.long	.LASF113
	.byte	0x2
	.value	0x369
	.byte	0x1
	.long	.LASF114
	.byte	0x3
	.long	0xcf9
	.uleb128 0xa
	.string	"__P"
	.value	0x369
	.byte	0x1a
	.long	0xcc9
	.uleb128 0xa
	.string	"__A"
	.value	0x369
	.byte	0x27
	.long	0xae3
	.byte	0
	.uleb128 0x11
	.long	.LASF115
	.value	0x363
	.long	.LASF117
	.long	0xae3
	.long	0xd19
	.uleb128 0xa
	.string	"__P"
	.value	0x363
	.byte	0x1f
	.long	0xcc4
	.byte	0
	.uleb128 0x11
	.long	.LASF116
	.value	0x2de
	.long	.LASF118
	.long	0xae3
	.long	0xd39
	.uleb128 0xa
	.string	"__X"
	.value	0x2de
	.byte	0x24
	.long	0xcc4
	.byte	0
	.uleb128 0x11
	.long	.LASF119
	.value	0x138
	.long	.LASF120
	.long	0xae3
	.long	0xd65
	.uleb128 0xa
	.string	"__A"
	.value	0x138
	.byte	0x18
	.long	0xae3
	.uleb128 0xa
	.string	"__B"
	.value	0x138
	.byte	0x25
	.long	0xae3
	.byte	0
	.uleb128 0x32
	.long	.LASF121
	.byte	0x2
	.byte	0x8d
	.byte	0x1
	.long	.LASF127
	.long	0xae3
	.byte	0x3
	.uleb128 0x18
	.string	"__A"
	.byte	0x8d
	.byte	0x18
	.long	0xae3
	.uleb128 0x18
	.string	"__B"
	.byte	0x8d
	.byte	0x25
	.long	0xae3
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x8
	.byte	0
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x18
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 11
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0x21
	.sleb128 8
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 9
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 3
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 2
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x13
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 11
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 3
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 11
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0x21
	.sleb128 0
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 11
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0x21
	.sleb128 25
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 2
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x20
	.uleb128 0x21
	.sleb128 3
	.uleb128 0x34
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 8
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 3
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 11
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x2107
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x21
	.byte	0
	.uleb128 0x2f
	.uleb128 0x21
	.sleb128 3
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x52
	.uleb128 0x1
	.uleb128 0x2138
	.uleb128 0xb
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x58
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x59
	.uleb128 0xb
	.uleb128 0x57
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x52
	.uleb128 0x1
	.uleb128 0x2138
	.uleb128 0xb
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x58
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x59
	.uleb128 0xb
	.uleb128 0x57
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 2
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x1f
	.uleb128 0x1b
	.uleb128 0x1f
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x1b
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x1c
	.uleb128 0x39
	.byte	0x1
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1d
	.uleb128 0x8
	.byte	0
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x18
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1e
	.uleb128 0x3b
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x1f
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x20
	.uleb128 0x15
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x21
	.uleb128 0x26
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x22
	.uleb128 0x15
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x23
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x24
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x25
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x87
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x26
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x27
	.uleb128 0x39
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x28
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x29
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x2a
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x2b
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.byte	0
	.byte	0
	.uleb128 0x2c
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x55
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2d
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x2e
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x52
	.uleb128 0x1
	.uleb128 0x2138
	.uleb128 0xb
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0xb
	.uleb128 0x57
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x2f
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x30
	.uleb128 0x48
	.byte	0
	.uleb128 0x7d
	.uleb128 0x1
	.uleb128 0x83
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x31
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x34
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x32
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x34
	.uleb128 0x19
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loclists,"",@progbits
	.long	.Ldebug_loc3-.Ldebug_loc2
.Ldebug_loc2:
	.value	0x5
	.byte	0x8
	.byte	0
	.long	0
.Ldebug_loc0:
.LVUS0:
	.uleb128 0
	.uleb128 .LVU4
	.uleb128 .LVU4
	.uleb128 .LVU50
	.uleb128 .LVU50
	.uleb128 0
.LLST0:
	.byte	0x4
	.uleb128 .LVL0-.Ltext0
	.uleb128 .LVL1-.Ltext0
	.uleb128 0x1
	.byte	0x54
	.byte	0x4
	.uleb128 .LVL1-.Ltext0
	.uleb128 .LVL19-.Ltext0
	.uleb128 0x1
	.byte	0x59
	.byte	0x4
	.uleb128 .LVL19-.Ltext0
	.uleb128 .LFE6625-.Ltext0
	.uleb128 0x1
	.byte	0x54
	.byte	0
.LVUS1:
	.uleb128 0
	.uleb128 .LVU4
	.uleb128 .LVU4
	.uleb128 .LVU47
	.uleb128 .LVU47
	.uleb128 .LVU50
	.uleb128 .LVU50
	.uleb128 0
.LLST1:
	.byte	0x4
	.uleb128 .LVL0-.Ltext0
	.uleb128 .LVL1-.Ltext0
	.uleb128 0x1
	.byte	0x51
	.byte	0x4
	.uleb128 .LVL1-.Ltext0
	.uleb128 .LVL16-.Ltext0
	.uleb128 0x1
	.byte	0x5c
	.byte	0x4
	.uleb128 .LVL16-.Ltext0
	.uleb128 .LVL19-.Ltext0
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x51
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL19-.Ltext0
	.uleb128 .LFE6625-.Ltext0
	.uleb128 0x1
	.byte	0x51
	.byte	0
.LVUS2:
	.uleb128 0
	.uleb128 .LVU4
	.uleb128 .LVU4
	.uleb128 .LVU48
	.uleb128 .LVU48
	.uleb128 .LVU50
	.uleb128 .LVU50
	.uleb128 0
.LLST2:
	.byte	0x4
	.uleb128 .LVL0-.Ltext0
	.uleb128 .LVL1-.Ltext0
	.uleb128 0x1
	.byte	0x52
	.byte	0x4
	.uleb128 .LVL1-.Ltext0
	.uleb128 .LVL17-.Ltext0
	.uleb128 0x1
	.byte	0x5d
	.byte	0x4
	.uleb128 .LVL17-.Ltext0
	.uleb128 .LVL19-.Ltext0
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x52
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL19-.Ltext0
	.uleb128 .LFE6625-.Ltext0
	.uleb128 0x1
	.byte	0x52
	.byte	0
.LVUS4:
	.uleb128 .LVU2
	.uleb128 .LVU4
	.uleb128 .LVU4
	.uleb128 .LVU49
	.uleb128 .LVU49
	.uleb128 .LVU50
	.uleb128 .LVU50
	.uleb128 0
.LLST4:
	.byte	0x4
	.uleb128 .LVL0-.Ltext0
	.uleb128 .LVL1-.Ltext0
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL1-.Ltext0
	.uleb128 .LVL18-.Ltext0
	.uleb128 0x1
	.byte	0x5f
	.byte	0x4
	.uleb128 .LVL18-.Ltext0
	.uleb128 .LVL19-.Ltext0
	.uleb128 0x3
	.byte	0x74
	.sleb128 4
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL19-.Ltext0
	.uleb128 .LFE6625-.Ltext0
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0
.LVUS5:
	.uleb128 .LVU4
	.uleb128 .LVU7
	.uleb128 .LVU7
	.uleb128 .LVU38
	.uleb128 .LVU38
	.uleb128 .LVU41
	.uleb128 .LVU41
	.uleb128 .LVU46
.LLST5:
	.byte	0x4
	.uleb128 .LVL1-.Ltext0
	.uleb128 .LVL2-.Ltext0
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL2-.Ltext0
	.uleb128 .LVL11-.Ltext0
	.uleb128 0x1
	.byte	0x53
	.byte	0x4
	.uleb128 .LVL11-.Ltext0
	.uleb128 .LVL12-.Ltext0
	.uleb128 0x3
	.byte	0x73
	.sleb128 -1
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL12-.Ltext0
	.uleb128 .LVL15-.Ltext0
	.uleb128 0x1
	.byte	0x53
	.byte	0
.LVUS7:
	.uleb128 .LVU14
	.uleb128 .LVU50
.LLST7:
	.byte	0x4
	.uleb128 .LVL4-.Ltext0
	.uleb128 .LVL19-.Ltext0
	.uleb128 0x1
	.byte	0x61
	.byte	0
.LVUS10:
	.uleb128 .LVU16
	.uleb128 .LVU17
.LLST10:
	.byte	0x4
	.uleb128 .LVL4-.Ltext0
	.uleb128 .LVL5-.Ltext0
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0
.LVUS12:
	.uleb128 .LVU18
	.uleb128 .LVU22
.LLST12:
	.byte	0x4
	.uleb128 .LVL5-.Ltext0
	.uleb128 .LVL6-.Ltext0
	.uleb128 0x1
	.byte	0x50
	.byte	0
.LVUS13:
	.uleb128 .LVU22
	.uleb128 .LVU25
.LLST13:
	.byte	0x4
	.uleb128 .LVL6-.Ltext0
	.uleb128 .LVL6-.Ltext0
	.uleb128 0x11
	.byte	0x72
	.sleb128 0
	.byte	0xc
	.long	0xffffffff
	.byte	0x1a
	.byte	0x74
	.sleb128 0
	.byte	0x22
	.byte	0x33
	.byte	0x24
	.byte	0x79
	.sleb128 0
	.byte	0x22
	.byte	0x9f
	.byte	0
.LVUS15:
	.uleb128 .LVU25
	.uleb128 .LVU31
.LLST15:
	.byte	0x4
	.uleb128 .LVL6-.Ltext0
	.uleb128 .LVL9-.Ltext0
	.uleb128 0x1
	.byte	0x61
	.byte	0
.LVUS9:
	.uleb128 .LVU11
	.uleb128 .LVU14
.LLST9:
	.byte	0x4
	.uleb128 .LVL3-.Ltext0
	.uleb128 .LVL4-.Ltext0
	.uleb128 0x1
	.byte	0x5b
	.byte	0
.LVUS17:
	.uleb128 .LVU35
	.uleb128 .LVU39
.LLST17:
	.byte	0x4
	.uleb128 .LVL10-.Ltext0
	.uleb128 .LVL12-.Ltext0
	.uleb128 0x1
	.byte	0x61
	.byte	0
.LVUS18:
	.uleb128 .LVU35
	.uleb128 .LVU39
.LLST18:
	.byte	0x4
	.uleb128 .LVL10-.Ltext0
	.uleb128 .LVL12-.Ltext0
	.uleb128 0x1
	.byte	0x5b
	.byte	0
.Ldebug_loc3:
	.section	.debug_aranges,"",@progbits
	.long	0x2c
	.value	0x2
	.long	.Ldebug_info0
	.byte	0x8
	.byte	0
	.value	0
	.value	0
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.quad	0
	.quad	0
	.section	.debug_rnglists,"",@progbits
.Ldebug_ranges0:
	.long	.Ldebug_ranges3-.Ldebug_ranges2
.Ldebug_ranges2:
	.value	0x5
	.byte	0x8
	.byte	0
	.long	0
.LLRL3:
	.byte	0x4
	.uleb128 .LBB18-.Ltext0
	.uleb128 .LBE18-.Ltext0
	.byte	0x4
	.uleb128 .LBB42-.Ltext0
	.uleb128 .LBE42-.Ltext0
	.byte	0
.LLRL6:
	.byte	0x4
	.uleb128 .LBB20-.Ltext0
	.uleb128 .LBE20-.Ltext0
	.byte	0x4
	.uleb128 .LBB40-.Ltext0
	.uleb128 .LBE40-.Ltext0
	.byte	0x4
	.uleb128 .LBB41-.Ltext0
	.uleb128 .LBE41-.Ltext0
	.byte	0
.LLRL8:
	.byte	0x4
	.uleb128 .LBB21-.Ltext0
	.uleb128 .LBE21-.Ltext0
	.byte	0x4
	.uleb128 .LBB24-.Ltext0
	.uleb128 .LBE24-.Ltext0
	.byte	0
.LLRL11:
	.byte	0x4
	.uleb128 .LBB26-.Ltext0
	.uleb128 .LBE26-.Ltext0
	.byte	0x4
	.uleb128 .LBB29-.Ltext0
	.uleb128 .LBE29-.Ltext0
	.byte	0
.LLRL14:
	.byte	0x4
	.uleb128 .LBB32-.Ltext0
	.uleb128 .LBE32-.Ltext0
	.byte	0x4
	.uleb128 .LBB35-.Ltext0
	.uleb128 .LBE35-.Ltext0
	.byte	0
.LLRL16:
	.byte	0x4
	.uleb128 .LBB36-.Ltext0
	.uleb128 .LBE36-.Ltext0
	.byte	0x4
	.uleb128 .LBB39-.Ltext0
	.uleb128 .LBE39-.Ltext0
	.byte	0
.Ldebug_ranges3:
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF83:
	.string	"getenv"
.LASF119:
	.string	"_mm256_mul_pd"
.LASF49:
	.string	"uint_fast16_t"
.LASF124:
	.string	"rand"
.LASF95:
	.string	"system"
.LASF113:
	.string	"_mm256_store_pd"
.LASF99:
	.string	"_ZSt3divll"
.LASF85:
	.string	"mblen"
.LASF4:
	.string	"unsigned int"
.LASF98:
	.string	"__gnu_cxx"
.LASF54:
	.string	"intmax_t"
.LASF51:
	.string	"uint_fast64_t"
.LASF45:
	.string	"int_fast16_t"
.LASF12:
	.string	"__int32_t"
.LASF87:
	.string	"wchar_t"
.LASF126:
	.string	"_Z12dgemm_avx256jPKdS0_Pd"
.LASF26:
	.string	"__uintmax_t"
.LASF100:
	.string	"_ZN9__gnu_cxx3divExx"
.LASF21:
	.string	"__int_least32_t"
.LASF104:
	.string	"strtoull"
.LASF112:
	.string	"__bf16"
.LASF115:
	.string	"_mm256_load_pd"
.LASF60:
	.string	"_ZSt3absd"
.LASF58:
	.string	"_ZSt3abse"
.LASF59:
	.string	"_ZSt3absf"
.LASF56:
	.string	"_ZSt3absg"
.LASF47:
	.string	"int_fast64_t"
.LASF106:
	.string	"strtold"
.LASF57:
	.string	"_ZSt3absn"
.LASF103:
	.string	"strtoll"
.LASF41:
	.string	"uint_least16_t"
.LASF34:
	.string	"uint32_t"
.LASF28:
	.string	"int8_t"
.LASF88:
	.string	"mbtowc"
.LASF67:
	.string	"float"
.LASF29:
	.string	"int16_t"
.LASF37:
	.string	"int_least16_t"
.LASF55:
	.string	"uintmax_t"
.LASF109:
	.string	"__v4df"
.LASF66:
	.string	"long long unsigned int"
.LASF11:
	.string	"__uint16_t"
.LASF43:
	.string	"uint_least64_t"
.LASF101:
	.string	"lldiv"
.LASF102:
	.string	"atoll"
.LASF63:
	.string	"size_t"
.LASF92:
	.string	"strtod"
.LASF36:
	.string	"int_least8_t"
.LASF31:
	.string	"int64_t"
.LASF121:
	.string	"_mm256_add_pd"
.LASF39:
	.string	"int_least64_t"
.LASF40:
	.string	"uint_least8_t"
.LASF22:
	.string	"__uint_least32_t"
.LASF82:
	.string	"bsearch"
.LASF16:
	.string	"__uint64_t"
.LASF127:
	.string	"_Z13_mm256_add_pdDv4_dS_"
.LASF27:
	.string	"char"
.LASF70:
	.string	"5div_t"
.LASF125:
	.string	"dgemm_avx256"
.LASF89:
	.string	"quick_exit"
.LASF32:
	.string	"uint8_t"
.LASF110:
	.string	"__m256d"
.LASF68:
	.string	"quot"
.LASF86:
	.string	"mbstowcs"
.LASF64:
	.string	"long long int"
.LASF111:
	.string	"_Float16"
.LASF9:
	.string	"__int16_t"
.LASF118:
	.string	"_Z19_mm256_broadcast_sdPKd"
.LASF122:
	.ascii	"GNU C++17 13.1.1 20230429 -march=znver2 -mmmx -mpopcnt -msse"
	.ascii	" -msse2 -msse3 -mssse3 -msse4.1 -msse4.2 -mavx -mavx2 -msse4"
	.ascii	"a -mno-fma4 -mno-xop -mfma -mno-avx512f -mbmi -mbmi2 -maes -"
	.ascii	"mpclmul -mno-avx512vl -mno-avx512bw -mno-avx512dq -mno-avx51"
	.ascii	"2cd -mno-avx512er -mno-avx512pf -mno-avx512vbmi -mno-avx512i"
	.ascii	"fma -mno-avx5124vnniw -mno-avx5124fmaps -mno-avx512vpopcntdq"
	.ascii	" -mno-avx512vbmi2 -mno-gfni -mno-vpclmulqdq -mno-avx512vnni "
	.ascii	"-mno-avx512bitalg -mno-avx512bf16 -mno-avx512vp2intersect -m"
	.ascii	"no-3dnow -madx -mabm -mno-cldemote -mclflushopt -mclwb -mclz"
	.ascii	"ero -mcx16 -mno-enqcmd -mf16c -mfsgsbase -mfxsr -mno-hle -ms"
	.ascii	"ahf -mno-lwp -mlzcnt -mmovbe -mno-movdir64b -mno-movdiri -mm"
	.ascii	"waitx -mno-pconfig -mno-pku -mno-prefetchwt1 -mprfchw -mno-p"
	.ascii	"twrite -mrdpid -mrdrnd -mrdseed -mno-rtm -mno-serialize -mno"
	.ascii	"-sgx -msha -mno-shstk -mno-tbm -mno-tsxldtrk -mno-vaes -mno-"
	.ascii	"waitpkg -mwbnoinvd -mxsave -mxsavec -mxsaveopt -mxsaves -mno"
	.ascii	"-amx-tile -mno-amx-int8 -mno-amx-bf16 -mno-uintr -mno-hreset"
	.ascii	" -mno-kl -mno-widekl -mno-av"
	.string	"xvnni -mno-avx512fp16 -mno-avxifma -mno-avxvnniint8 -mno-avxneconvert -mno-cmpccxadd -mno-amx-fp16 -mno-prefetchi -mno-raoint -mno-amx-complex --param=l1-cache-size=32 --param=l1-cache-line-size=64 --param=l2-cache-size=512 -mtune=znver2 -masm=intel -g -O3"
.LASF44:
	.string	"int_fast8_t"
.LASF84:
	.string	"ldiv"
.LASF75:
	.string	"__compar_fn_t"
.LASF19:
	.string	"__int_least16_t"
.LASF91:
	.string	"srand"
.LASF50:
	.string	"uint_fast32_t"
.LASF7:
	.string	"__int8_t"
.LASF14:
	.string	"__int64_t"
.LASF25:
	.string	"__intmax_t"
.LASF65:
	.string	"long double"
.LASF52:
	.string	"intptr_t"
.LASF33:
	.string	"uint16_t"
.LASF117:
	.string	"_Z14_mm256_load_pdPKd"
.LASF23:
	.string	"__int_least64_t"
.LASF18:
	.string	"__uint_least8_t"
.LASF46:
	.string	"int_fast32_t"
.LASF10:
	.string	"short int"
.LASF114:
	.string	"_Z15_mm256_store_pdPdDv4_d"
.LASF15:
	.string	"long int"
.LASF76:
	.string	"atexit"
.LASF107:
	.string	"__float128"
.LASF35:
	.string	"uint64_t"
.LASF72:
	.string	"ldiv_t"
.LASF8:
	.string	"__uint8_t"
.LASF42:
	.string	"uint_least32_t"
.LASF77:
	.string	"at_quick_exit"
.LASF17:
	.string	"__int_least8_t"
.LASF53:
	.string	"uintptr_t"
.LASF20:
	.string	"__uint_least16_t"
.LASF94:
	.string	"strtoul"
.LASF5:
	.string	"long unsigned int"
.LASF30:
	.string	"int32_t"
.LASF38:
	.string	"int_least32_t"
.LASF120:
	.string	"_Z13_mm256_mul_pdDv4_dS_"
.LASF62:
	.string	"_ZSt3absl"
.LASF108:
	.string	"__int128"
.LASF69:
	.string	"div_t"
.LASF2:
	.string	"unsigned char"
.LASF13:
	.string	"__uint32_t"
.LASF61:
	.string	"_ZSt3absx"
.LASF116:
	.string	"_mm256_broadcast_sd"
.LASF123:
	.string	"decltype(nullptr)"
.LASF105:
	.string	"strtof"
.LASF48:
	.string	"uint_fast8_t"
.LASF96:
	.string	"wcstombs"
.LASF93:
	.string	"strtol"
.LASF24:
	.string	"__uint_least64_t"
.LASF71:
	.string	"6ldiv_t"
.LASF73:
	.string	"7lldiv_t"
.LASF6:
	.string	"signed char"
.LASF3:
	.string	"short unsigned int"
.LASF74:
	.string	"lldiv_t"
.LASF78:
	.string	"atof"
.LASF80:
	.string	"atoi"
.LASF81:
	.string	"atol"
.LASF97:
	.string	"wctomb"
.LASF79:
	.string	"double"
.LASF90:
	.string	"qsort"
	.section	.debug_line_str,"MS",@progbits,1
.LASF0:
	.string	"../src/dgemm_avx256.cpp"
.LASF1:
	.string	"/home/czg/matrix-matrix-multiply/asm"
	.ident	"GCC: (GNU) 13.1.1 20230429"
	.section	.note.GNU-stack,"",@progbits
