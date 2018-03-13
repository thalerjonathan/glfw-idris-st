#ifndef __GL_GLFWIDRISST_H
#define __GL_GLFWIDRISST_H

#include <idris_rts.h>

int* allocIntArgPtr();
void freeIntArgPtr(int*);
int intPtrToValue(int*);

#endif // __GL_GLFWIDRISST_H