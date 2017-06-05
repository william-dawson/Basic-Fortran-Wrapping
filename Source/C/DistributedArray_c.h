#ifndef DISTRIBUTEDARRAY_c_h
#define DISTRIBUTEDARRAY_c_h

void ConstructDistributedArray_wrp(int *ih_this, const int *length);
void SetDistributedArrayAt_wrp(const int *ih_this, const int *index,
                               const double *value);
double SumDistributedArray_wrp(const int *ih_this);
void DestructDistributedArray_wrp(int *ih_this);

#endif
