CC=gcc
OPTIONS=-g -Wall -Wextra -Werror -Wshadow -Wconversion -std=gnu99
COMPILE=$(CC) $(OPTIONS)

binaries = \
	counters counters.v1 counters.v2 \
	counters2 counters2.v1 counters2.v2 \
	flops flops2 \
	hello_omp \
	mm mm_omp mm2 \
	mm2 mm2_omp \
	sv sv_omp

all: $(binaries)

counters: counters.c
	$(COMPILE) -I/share/apps/papi/include/ $< /share/apps/papi/lib/libpapi.a -o $@

counters.v1: counters.v1.c
	$(COMPILE) -I/share/apps/papi/include/ $< /share/apps/papi/lib/libpapi.a -o $@

counters.v2: counters.v2.c
	$(COMPILE) -I/share/apps/papi/include/ $< /share/apps/papi/lib/libpapi.a -o $@

counters2: counters2.c
	$(COMPILE) -I/share/apps/papi/include/ $< /share/apps/papi/lib/libpapi.a -o $@

counters2.v1: counters2.v1.c
	$(COMPILE) -I/share/apps/papi/include/ $< /share/apps/papi/lib/libpapi.a -o $@

counters2.v2: counters2.v2.c
	$(COMPILE) -I/share/apps/papi/include/ $< /share/apps/papi/lib/libpapi.a -o $@

flops: flops.c
	$(COMPILE) -I/share/apps/papi/include/ $< /share/apps/papi/lib/libpapi.a -o $@

flops2: flops2.c
	$(COMPILE) -I/share/apps/papi/include/ $< /share/apps/papi/lib/libpapi.a -o $@

hello_omp: hello_omp.c
	$(COMPILE) -fopenmp $< -o $@

mm: mm.c
	$(COMPILE) $< -o $@

mm_omp: mm.c
	$(COMPILE) -fopenmp $< -o $@

mm2: mm2.c
	$(COMPILE) $< -o $@

mm2_omp: mm2.c
	$(COMPILE) -fopenmp $< -o $@

sv: sv.c
	$(COMPILE) -fopenmp $< -o $@

sv_omp: sv.c
	$(COMPILE) -fopenmp -DUSE_REDUCTION=1 $< -o $@

clean:
	@rm -f $(binaries)

.PHONY: clean
