#include "glfw_idris_st.h"

#ifdef _WIN32
#include <Windows.h>
#else
#include <unistd.h>
#endif

#define INTARGS_SIZE 16

static int intArgPtrs[INTARGS_SIZE] = { 0 };
static bool intArgPtrsUsed[INTARGS_SIZE] = { 0 };

int*
allocIntArgPtr()
{
  int* ptr = 0;

  for (unsigned int i = 0; i < INTARGS_SIZE; ++i)
  {
    if (0 == intArgPtrsUsed[ i ])
    {
      intArgPtrsUsed[i] = 1;
      ptr = &intArgPtrs[i];
      break;
    }
  }

  return ptr;
}

void
freeIntArgPtr(int* ptr)
{
  for (unsigned int i = 0; i < INTARGS_SIZE; ++i)
  {
    if (ptr == &intArgPtrs[i])
    {
      intArgPtrsUsed[ i ] = 0;
      break;
    }
  }
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