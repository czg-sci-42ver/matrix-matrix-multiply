#
# makefile
#
CXX = g++
CXXFLAGS = -S -fverbose-asm -g -march=native -mtune=native -masm=intel -O3
#LIB = ./lib/vec.c
#PROFBIN = pprof

#SRCS = $(wildcard *.c)
SRCS = ../src/dgemm_avx256.cpp
ASM_PROGS_prefix = $(patsubst %.cpp,%.s,$(SRCS))
ASM_PROGS = $(subst ../src/,,$(ASM_PROGS_prefix))
LST_FILE=$(subst s,lst,$(ASM_PROGS))
#PROGS_TEST = $(patsubst %.c,%.test,$(SRCS))

all: $(ASM_PROGS)
	@echo run all $(ASM_PROGS)

$(ASM_PROGS): 
	@echo run $@ $(ASM_PROGS)
	$(CXX) $(CXXFLAGS) -o $@ $(SRCS) 
	(as -alhnd $@ > $(LST_FILE))

#test: $(PROGS_TEST)
#
#%.test: %
#	./$<
#
#5.18.prof:
#	gcc -std=c99 -lprofiler 5.18.c -o prof.5.18
#	env CPUPROFILE=/tmp/prof.out ./prof.5.18
#	$(PROFBIN) prof.5.18 /tmp/prof.out --text
#
#5.19.prof:
#	gcc -std=c99 -lprofiler 5.19.c -o prof.5.19
#	env CPUPROFILE=/tmp/prof.out ./prof.5.19
#	$(PROFBIN) prof.5.19 /tmp/prof.out --text

.PHONY : clean
clean:
	find . -type f -executable -print0 | xargs -0 rm --

# vim:ft=make
#

