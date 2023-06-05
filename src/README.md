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
# https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html
typedef double __m256d __attribute__((__vector_size__(32), __aligned__(32)));
```
- according to this [Q&A](https://stackoverflow.c_mm256_load_pduestions/76405912/question-about-dgemm-test-mm256-load-pdc-i-j-n-in-cod), the book use column-major annotation in comments although it use C code ...
  - so the logic of the code is C=B*A
```cpp
C[j][i]~C[j][i+3] -> c0 (256 bit, init 0)
c0 += A[k][i]~A[k][i+3]*B[j][k] -> C[j][i] = sum(A[k][i]*B[j][k],k:0~n-1)
// then C[j+1][i]~C[j+1][i+3] ...
// so row must be multiple of 4, which also said by `_mm256_load_pd`
```