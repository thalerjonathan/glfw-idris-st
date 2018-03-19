#include "glfw_idris_st.h"

#ifdef _WIN32
#include <Windows.h>
#else
#include <unistd.h>
#endif

#define INTARGS_SIZE 32

static int intArgPtrs[INTARGS_SIZE] = { 0 };
static unsigned int nextPtr = 0;

int*
nextIntArgPtr()
{
  return &intArgPtrs[nextPtr++];
}

int
intPtrToValue(int* ptr)
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