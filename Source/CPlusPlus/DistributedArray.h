#ifndef DistributedArray_h
#define DistributedArray_h

#include "Wrapper.h"

////////////////////////////////////////////////////////////////////////////////
namespace FW {
//////////////////////////////////////////////////////////////////////////////
class DistributedArray {
public:
  //! Construct The Distributed Array
  //!\param length of the array.
  DistributedArray(int length);
  //! Set a value in the distributed array.
  //!\param index of the value
  //!\param value to set.
  void Set(int index, double value);
  //! Sum up the values in the array.
  //!\result sum(this)
  double Sum() const;
  //! Standard Destructor.
  ~DistributedArray();

private:
  //! Handle to the actual data.
  int ih_this[SIZE_wrp];
};
} // namespace FW
#endif
