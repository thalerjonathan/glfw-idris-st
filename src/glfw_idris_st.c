#include "glfw_idris_st.h"

#ifdef _WIN32
#include <Windows.h>
#else
#include <unistd.h>
#endif

#define INTARGS_SIZE 32
#define DOUBLEARGS_SIZE 16

static int intArgPtrs[INTARGS_SIZE] = { 0 };
static unsigned int nextIntPtr = 0;

static double doubleArgPtrs[DOUBLEARGS_SIZE] = { 0 };
static unsigned int nextDoublePtr = 0;

int*
nextIntArgPtr()
{
  int* ptr = &intArgPtrs[nextIntPtr++];
  if (nextIntPtr >= INTARGS_SIZE)
    nextIntPtr = 0;

  return ptr;
}

double*
nextDoubleArgPtr()
{
  double* ptr = &doubleArgPtrs[nextDoublePtr++];
  if (nextDoublePtr >= DOUBLEARGS_SIZE)
    nextDoublePtr = 0;

    return ptr;
}

int
intPtrToValue(int* ptr)
{
  return *ptr;
}

double
doublePtrToValue(double* ptr)
{
  return *ptr;
}

void 
sleepMillis(unsigned int usecs)
{
  #ifdef _WIN32
    Sleep(usecs);
  #else
    usleep(usecs*1000);  /* sleep for 100 milliSeconds */
  #endif
}