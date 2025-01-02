bin_PROGRAMS = \
	pac3_deadlock pac3_deadlock_1024 pac3_deadlock2_1024 \
	pac3_deadlockv0 pac3_deadlockv1 pac3_deadlockv2 \
	pac3_hello \
	pac3_mpi_send_recv \
	pac3_ranks \
	pac3_rma \
	pac3_stencil

# AM_CFLAGS = -Wall -Wextra -Werror
AM_CFLAGS = -Wall -Wextra

pac3_deadlock_SOURCES = deadlock.c

pac3_deadlock_1024_SOURCES  = deadlock.SIZE.c
pac3_deadlock_1024_CPPFLAGS = -D SIZE=1024

pac3_deadlock2_1024_SOURCES = deadlock.SIZE.v2.c
pac3_deadlock2_1024_CPPFLAGS = -D SIZE=1024

pac3_deadlockv0_SOURCES    = deadlock.0.c
pac3_deadlockv1_SOURCES    = deadlock.1.c
pac3_deadlockv2_SOURCES    = deadlock.2.c
pac3_hello_SOURCES         = hello.c
pac3_mpi_send_recv_SOURCES = mpi_send_recv.c
pac3_ranks_SOURCES         = ranks.c
pac3_rma_SOURCES           = rma.c
pac3_stencil_SOURCES       = stencil.c
