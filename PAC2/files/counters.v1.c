#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <errno.h>
#include <sys/types.h>
#include <memory.h>
#include <malloc.h>
#include <papi.h>

#define SIZE 1000
#define NUM_EVENTS 3

int main() {
  float matrixa[SIZE][SIZE], matrixb[SIZE][SIZE], mresult[SIZE][SIZE];
  int i,j,k;
  int events[NUM_EVENTS] = {
    PAPI_L2_DCM, /* Level 2 data cache misses */
    /* PAPI_L3_TCM, */ /* Level 3 total cache misses */
    /* PAPI_TLB_DM, */ /* Data translation lookaside buffer misses */
    PAPI_TOT_INS,
    PAPI_FP_OPS
  };
  int ret;
  long long values[NUM_EVENTS];

  if (PAPI_num_counters() < NUM_EVENTS) {
  	fprintf(stderr, "No hardware counters here, or PAPI not supported.\n");
  	exit(1);
  }

  if ((ret = PAPI_start_counters(events, NUM_EVENTS)) != PAPI_OK) {
  	fprintf(stderr, "PAPI failed to start counters: %s\n", PAPI_strerror(ret));
  	exit(1);
  }

  /* Initialize the Matrix arrays */
  for ( i=0; i<SIZE*SIZE; i++ ){
    mresult[0][i] = 0.0f;
    matrixa[0][i] = matrixb[0][i] = ((float)rand())*1.1f; }

  /* Matrix-Matrix multiply */
  for (i=0;i<SIZE;i++)
   for(j=0;j<SIZE;j++)
    for(k=0;k<SIZE;k++)
      mresult[i][j]=mresult[i][j] + matrixa[i][k]*matrixb[k][j];

  if ((ret = PAPI_read_counters(values, NUM_EVENTS)) != PAPI_OK) {
  	fprintf(stderr, "PAPI failed to read counters: %s\n", PAPI_strerror(ret));
  	exit(1);
  }

  printf("Level 2 data cache misses = %lld\n",values[0]);
/*  printf("Level 3 total cache misses = %lld\n",values[0]); */
/*  printf("Data translation lookaside buffer misses = %lld\n",values[0]); */
  printf("Total instructions %lld\n", values[1]);
  printf("Total hardware flops = %lld\n",values[2]);

  exit(0);
}
