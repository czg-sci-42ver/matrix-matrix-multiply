# outline
- 'FIGURE 3.19' Unoptimized -> [dgemm_basic](./dgemm_basic.cpp)
- 'FIGURE 3.21' using *subword-parallel* -> [dgemm_avx256](./dgemm_avx256.cpp) (implied by using `_mm256_` instructions)
- 'FIGURE 4.77' using *instruction-level* -> [dgemm_unrolled_avx256](./dgemm_unrolled_avx256.cpp)
  - here different `c[x]` has no dependency relation. So instruction-level.
- basic cache-block 'FIGURE 5.21' -> [dgemm_basic_blocked](./dgemm_basic_blocked.cpp)
# `dgemm_avx256`
- when `set(CMAKE_CXX_FLAGS "-Wall -Wextra -Wpedantic -g -fopenmp -march=native -mtune=native -mavx -mno-avx512f")`, see the following assembly with `../asm/O3_asm/` (instruction related with `;~` is obvious, so comment omitted):
```asm
; c0 = _mm256_add_pd(c0, /* c0 += A[i][k]*B[k][j] */
;_mm256_mul_pd( _mm256_load_pd(A + i + k * n), _mm256_broadcast_sd(B + k + j * n) ) );
   0x0000555555557660 <+0>:     85 ff                   test   edi,edi ;check n (i.e. first arg)
   0x0000555555557662 <+2>:     0f 84 98 00 00 00       je     0x555555557700 <dgemm_avx256(unsigned int, double const*, double const*, double*)+160 at /home/czg/matrix-matrix-multiply/src/dgemm_avx256.cpp:42>
   0x0000555555557668 <+8>:     55                      push   rbp ;callee save
   0x0000555555557669 <+9>:     49 89 f1                mov    r9,rsi ; A
   0x000055555555766c <+12>:    48 89 e5                mov    rbp,rsp ; change to new base pointer
   0x000055555555766f <+15>:    41 57                   push   r15 ; based on below `add    r15d,0x4`, this is i
   0x0000555555557671 <+17>:    45 31 ff                xor    r15d,r15d ; i=0
   0x0000555555557674 <+20>:    41 56                   push   r14
   0x0000555555557676 <+22>:    41 89 fe                mov    r14d,edi ; n, this won't change in this func
   0x0000555555557679 <+25>:    41 55                   push   r13
   0x000055555555767b <+27>:    49 89 cd                mov    r13,rcx ; C
   0x000055555555767e <+30>:    41 54                   push   r12
   0x0000555555557680 <+32>:    49 89 d4                mov    r12,rdx ; B
   0x0000555555557683 <+35>:    53                      push   rbx
   0x0000555555557684 <+36>:    66 66 2e 0f 1f 84 00 00 00 00 00        data16 cs nop WORD PTR [rax+rax*1+0x0]
   0x000055555555768f <+47>:    90                      nop
   ; i-block
   0x0000555555557690 <+48>:    44 89 fe                mov    esi,r15d ; $rsi=i
   0x0000555555557693 <+51>:    45 31 d2                xor    r10d,r10d ; one `j` copy? this is ivtmp.20(shown with `-fverbose-asm`) = j*n
   0x0000555555557696 <+54>:    31 db                   xor    ebx,ebx ; update j when new i-block
   0x0000555555557698 <+56>:    0f 1f 84 00 00 00 00 00 nop    DWORD PTR [rax+rax*1+0x0]
   ; j-block
   0x00005555555576a0 <+64>:    44 89 d2                mov    edx,r10d ; ivtmp.20
   0x00005555555576a3 <+67>:    31 c9                   xor    ecx,ecx ; ivtmp.15
   0x00005555555576a5 <+69>:    48 8d 04 32             lea    rax,[rdx+rsi*1] ;ivtmp.20+i
   0x00005555555576a9 <+73>:    4d 8d 5c c5 00          lea    r11,[r13+rax*8+0x0] ; 8-> double = 8 bytes, `C + i + j * n`
   0x00005555555576ae <+78>:    49 8d 04 d4             lea    rax,[r12+rdx*8] ; B+ivtmp.20(j*n), default k init to 0
   0x00005555555576b2 <+82>:    4c 01 f2                add    rdx,r14 ; tmp115->(j+1)*n; show B end in k-block
   0x00005555555576b5 <+85>:    c4 c1 7d 28 03          vmovapd ymm0,YMMWORD PTR [r11]
   0x00005555555576ba <+90>:    4d 8d 04 d4             lea    r8,[r12+rdx*8] ; B end
   0x00005555555576be <+94>:    66 90                   xchg   ax,ax ;nop
   ; k-block implied by `j...`
   0x00005555555576c0 <+96>:    89 ca                   mov    edx,ecx ; ivtmp.15->k*n
   0x00005555555576c2 <+98>:    c4 e2 7d 19 08          vbroadcastsd ymm1,QWORD PTR [rax] ; B...
=> 0x00005555555576c7 <+103>:   48 83 c0 08             add    rax,0x8 ; ivtmp.14 -> `B + k + j * n` add 8byte
   0x00005555555576cb <+107>:   01 f9                   add    ecx,edi ; ivtmp.15+=n
   0x00005555555576cd <+109>:   48 01 f2                add    rdx,rsi ; i+k*n
   0x00005555555576d0 <+112>:   c4 c2 f5 b8 04 d1       vfmadd231pd ymm0,ymm1,YMMWORD PTR [r9+rdx*8] ; A+i+k*n
   0x00005555555576d6 <+118>:   49 39 c0                cmp    r8,rax ; compare `B end` and current B `B...`
   0x00005555555576d9 <+121>:   75 e5                   jne    0x5555555576c0 <dgemm_avx256(unsigned int, double const*, double const*, double*)+96 at /usr/lib/gcc/x86_64-pc-linux-gnu/13.1.1/include/avxintrin.h:736> 
   ;k-end
   0x00005555555576db <+123>:   ff c3                   inc    ebx ; j++
   0x00005555555576dd <+125>:   c4 c1 7d 29 03          vmovapd YMMWORD PTR [r11],ymm0
   0x00005555555576e2 <+130>:   41 01 fa                add    r10d,edi ; ivtmp.20+=n
   0x00005555555576e5 <+133>:   39 df                   cmp    edi,ebx ; j<n ?
   0x00005555555576e7 <+135>:   75 b7                   jne    0x5555555576a0 <dgemm_avx256(unsigned int, double const*, double const*, double*)+64 at /home/czg/matrix-matrix-multiply/src/dgemm_avx256.cpp:32> 
   ;j-end
   0x00005555555576e9 <+137>:   41 83 c7 04             add    r15d,0x4 ; ~
   0x00005555555576ed <+141>:   41 39 ff                cmp    r15d,edi
   0x00005555555576f0 <+144>:   72 9e                   jb     0x555555557690 <dgemm_avx256(unsigned int, double const*, double const*, double*)+48 at /home/czg/matrix-matrix-multiply/src/dgemm_avx256.cpp:30>
   ;i-end
   0x00005555555576f2 <+146>:   c5 f8 77                vzeroupper
   0x00005555555576f5 <+149>:   5b                      pop    rbx
   0x00005555555576f6 <+150>:   41 5c                   pop    r12
   0x00005555555576f8 <+152>:   41 5d                   pop    r13
   0x00005555555576fa <+154>:   41 5e                   pop    r14
   0x00005555555576fc <+156>:   41 5f                   pop    r15
   0x00005555555576fe <+158>:   5d                      pop    rbp
   0x00005555555576ff <+159>:   c3                      ret
   0x0000555555557700 <+160>:   c3                      ret
```
- _mm256_load_pd definition
```bash
# from clang
# https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html
typedef double __m256d __attribute__((__vector_size__(32), __aligned__(32))); 

# from gcc
# more detailed https://gcc.gnu.org/onlinedocs/gcc-4.7.2/gcc/Function-Attributes.html
extern __inline __m256d __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm256_load_pd (double const *__P)

# https://gcc.gnu.org/onlinedocs/gcc-3.3/gcc/Type-Attributes.html
typedef double __m256d __attribute__ ((__vector_size__ (32),
				       __may_alias__));
```
  - artificial: 'using the *caller* location for all instructions within the inlined body'
  - may_alias: 'alias any other type of objects'
    - ['Type-based alias analysis'](https://en.wikipedia.org/wiki/Alias_analysis#Type-based_alias_analysis) just split all variable into different *alias classes* by type.
      - [type-safety](https://en.wikipedia.org/wiki/Type_safety#Definitions) 'those *sanctioned* by the type of the data'
      - pointer to local variable undefined but may [‘always works as expected’](https://stackoverflow.com/questions/49213172/c-local-variable-passed-by-reference-to-the-class-with-pointer-member)
    - so this can be recast to anything po
  - see mangled symbol using [`objdump`](https://stackoverflow.com/questions/4468770/c-name-mangling-decoder-for-g) or just [g++](https://stackoverflow.com/questions/12400105/getting-mangled-name-from-demangled-name)
  - [TU-local](https://en.cppreference.com/w/cpp/language/tu_local#:~:text=Translation%2Dunit%2Dlocal%20(TU,used%20in%20other%20translation%20units.) TODO
  - [different inline](https://stackoverflow.com/questions/216510/what-does-extern-inline-do/51229603#51229603) from [this comment](https://stackoverflow.com/questions/55884502/why-does-gnu-inline-attribute-affects-code-generation-so-much-compared-to-genera)
    - here `gnu_inline` 'never emit any symbol' which can be seen `maintenance print symbols|grep dgemm_avx256 --color=always` with `maintenance print symbols|grep _mm256_load_pd --color=always` in pwndbg
      - TODO after c++primer, [gnu89/gnu90](https://gcc.gnu.org/onlinedocs/gcc/C-Dialect-Options.html) [diff](https://en.wikipedia.org/wiki/Inline_function#gnu89) with gnu99, and why design as that?
        - although [this](https://blahg.josefsipek.net/?p=529) from wikipedia says well, which is also related with symbol by using `nm` as said above. So here `extern __inline` with `__gnu_inline__`(gnu90) -> never shown in symbols in  object file.
- according to this [Q&A](https://stackoverflow.c_mm256_load_pduestions/76405912/question-about-dgemm-test-mm256-load-pdc-i-j-n-in-cod), the book use column-major annotation in comments although it use C code ...
  - so the logic of the code is C=B*A
```cpp
C[j][i]~C[j][i+3] -> c0 (256 bit, init 0)
c0 += A[k][i]~A[k][i+3]*B[j][k] -> C[j][i] = sum(A[k][i]*B[j][k],k:0~n-1)
// then C[j+1][i]~C[j+1][i+3] ...
// so row must be multiple of 4, which also said by `_mm256_load_pd`
```
- above avx instruction explained
  - [vmovapd](https://www.felixcloutier.com/x86/movapd) 'can be used to load an XMM, YMM or ZMM register *from* an 128-bit, 256-bit or 512-bit *memory* location'
    - from [this](https://www.felixcloutier.com/x86/movapd#vmovapd--vex-256-encoded-version--load---and-register-copy-) `DEST[MAXVL-1:256]` zeroed (from intel doc MAXVL=512)
  - [vbroadcastsd](https://www.felixcloutier.com/x86/vbroadcast#fig-5-3) 'load floating-point values as one tuple', also [clear by seeing 'Operation'](https://www.felixcloutier.com/x86/vbroadcast#vbroadcastsd--vex-256-encoded-version-)
  - [vfmadd231pd](https://www.felixcloutier.com/x86/vfmadd132pd:vfmadd213pd:vfmadd231pd) clear by seeing 'Description',
    - kw: 'two, four or eight *packed* double precision', '[infinite precision intermediate](https://en.wikipedia.org/wiki/Arbitrary-precision_arithmetic)'
      - see [pep](https://peps.python.org/pep-0237/) which is similar to wikipedia example, 
        - floating-point : 'in a floating-point format as a significand *multiplied* by an arbitrary exponent','the mantissa was restricted to a hundred digits or fewer'
    - ['MXCSR'](https://help.totalview.io/previous_releases/2019/html/index.html#page/Reference_Guide/Intelx86MXSCRRegister_2.html) in ['RoundFPControl_MXCSR'](https://www.felixcloutier.com/x86/vfmadd132pd:vfmadd213pd:vfmadd231pd#vfmadd231pd-dest--src2--src3--vex-encoded-version-) (which has no definition in intel doc)
  - vzeroupper same as above
    - this is to avoid [implicit widening](https://stackoverflow.com/questions/66874161/first-use-of-avx-256-bit-vectors-slows-down-128-bit-vector-and-avx-scalar-ops)(from [this more detailed](https://stackoverflow.com/questions/49019614/is-it-useful-to-use-vzeroupper-if-your-programlibraries-contain-no-sse-instruct)) to keep outside function not using avx unexpectedly.
      - also not use avx occationly because of 'Warm-up period'
# `dgemm_unrolled` (avx512)
```cpp
c[i]~c[UNROLL]=C[j][i]...C[j][i+7]~C[j][i+UNROLL*8]...C[j][i+7+UNROLL*8] // one line of C with 8(512/64=8) * UNROLL `double` variable
```
- here in i-loop, load one *line* from C, so from $B*A=C$,j-loop should also load one *line* of B, and first number of line from B $B_{jk}$
should be calculated with one whole line in A, which implies using `broadcast` with $B_{jk}$, 
then should add $n$ multiply result to each number (i.e. k from 0 to $n$). `A + n * k + i` in `A + n * k + r * 8 + i` means `ptr(A[k][i])` based on `n` meaning and `r` is unroll variable, so `A + n * k + r * 8 + i` is `ptr(A[k][i+r*8])`.
- so all in all, above is just unrolling to calculate more elements with each C *line*
# using `-funroll-loops`
- COD risc-v p651 says 'do the unrolling at −O3 optimization', but not at all.
- after `objdump`, `-funroll-loops` isn't as 'intelligent' as `dgemm_unrolled` program, which may add redundant calculation (more `vbroadcastsd` and `vfmadd132pd`), although basic idea is same(just put multiple original subsequent loops in one loop)
```bash
# -funroll-loops
         dgemm_basic:  elapsed-time=    328731
 dgemm_basic_blocked:  elapsed-time=    157191     speed-up=   2.09128
        dgemm_avx256:  elapsed-time=     81859     speed-up=   4.01582
dgemm_unrolled_avx256:  elapsed-time=     24795     speed-up=    13.258
# O3 without -funroll-loops
         dgemm_basic:  elapsed-time=    321941
 dgemm_basic_blocked:  elapsed-time=    153672     speed-up=   2.09499
        dgemm_avx256:  elapsed-time=     85452     speed-up=   3.76751
dgemm_unrolled_avx256:  elapsed-time=     23278     speed-up=   13.8303
```
- why [not unroll sometimes](https://stackoverflow.com/questions/24196076/is-gcc-loop-unrolling-flag-really-effective)
  - ’usually makes the code run slower.‘,'have little memory','-fprofile-arcs'
# turbo
- according to some web resources, turbo core is default on with new ryzen cpu (at least muy ryzen 48000h), also see my ~~bitbucket repo automatic_command->archlinux_init~~, [csapp3e](https://github.com/czg-sci-42ver/csapp3e) 'turbo core'
- from amd [official](https://www.amd.com/en/technologies/turbo-core) 'a core is operating below maximum' & 'your workload subsides' and [this 'only single core to the advertised speed'](https://www.quora.com/Does-Turbo-Boost-increase-the-clock-speed-of-only-one-core-in-a-dual-core-processor), so my 4800h only achieve 4200MHZ one core one time mostly (although sometimes two core 4100MHZ meanwhile).
## make all P0
```bash
$ /mnt/ubuntu/home/czg/csapp3e/COD/turbo.sh
$ sudo cpupower frequency-info                                        
analyzing CPU 1:
  driver: acpi-cpufreq
  CPUs which run at the same hardware frequency: 1
  CPUs which need to have their frequency coordinated by software: 1
  maximum transition latency:  Cannot determine or is not supported.
  hardware limits: 1.40 GHz - 2.90 GHz
  available frequency steps:  2.90 GHz, 1.70 GHz, 1.40 GHz
  available cpufreq governors: conservative ondemand userspace powersave performance schedutil
  current policy: frequency should be within 2.90 GHz and 2.90 GHz. # all P0
                  The governor "userspace" may decide which speed to use
                  within this range.
  current CPU frequency: 2.90 GHz (asserted by call to hardware)
  boost state support:
    Supported: yes
    Active: yes # turbo core active
    Boost States: 0
    Total States: 3
    Pstate-P0:  2900MHz
    Pstate-P1:  1700MHz
    Pstate-P2:  1400MHz
```
- notice because of only one core turbo core, tested on my machine, the speed not increase a lot by making all P0. But it should help from nonturbo to turbo (not tested).
# dgemm_basic_blocked
- still $C=B*A$, `cij += A[i + k * n] * B[k + j * n];`: B[j][k]*A[k][i]
- ~~here, if think from C row-major, every j-loop may use new `C` because new row. Whether to replace original cache depends on the cache design. Here think of the worst case which will *replace* the original. In the k-loop, A always fetch new cache and B not. So every i-loop, fetch *BLOCKSIZE* C element,~~
  - ~~if from Fortran column-major,~~
- Here block assume