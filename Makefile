CC=gcc
CXX=g++
CFLAGS=-Wall -Werror -O3 -g -pg
CXXFLAGS=-std=c++0x

CXXSRCS= stlmap.cc stluomap.cc \
	sparsehash.cc
SRCS=none.c bsdtree.c uthash.c \
	critbit.c 

OBJS=$(SRCS:.c=.o) $(CXXSRCS:.cc=.o)
BINS=$(OBJS:.o=.bin)
OUTS=$(OBJS:.o=.out)

export TIME=%Esec, %Mk

all: run

run: $(OUTS)

%.out: %.bin
	time ./$< | tee $@

sparsehash.bin: sparsehash.o helper.o
	$(CXX) $(CFLAGS) $^ -o $@

%.bin: %.o helper.o
	$(CXX) $(CFLAGS) $^ -o $@

%.o: %.c
	$(CC) $(CFLAGS) -c $<

%.o: %.cc
	$(CXX) $(CFLAGS) $(CXXFLAGS) -c $<

$(OBJS): helper.h

clean:
	rm -f *.o *.bin *.out
