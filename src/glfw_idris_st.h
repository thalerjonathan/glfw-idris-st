#ifndef __GL_GLFWIDRISST_H
#define __GL_GLFWIDRISST_H

#include <idris_rts.h>

int* nextIntArgPtr();
double* nextDoubleArgPtr();

int intPtrToValue(int*);
double doublePtrToValue(double*);

void sleepMillis(unsigned int);

#endif // __GL_GLFWIDRISST_H