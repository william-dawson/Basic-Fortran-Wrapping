!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!> A module for wrapping the distributed array Fortran module.
MODULE DistributedArrayModule_wrp
  USE DistributedArrayModule
  USE WrapperModule
  USE iso_c_binding
  IMPLICIT NONE
  PRIVATE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  TYPE, PUBLIC :: DistributedArray_wrp
     !> Actual Data
     TYPE(DistributedArray_t), POINTER :: DATA
  END TYPE DistributedArray_wrp
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  PUBLIC :: ConstructDistributedArray_wrp
  PUBLIC :: SetDistributedArrayAt_wrp
  PUBLIC :: SumDistributedArray_wrp
  PUBLIC :: DestructDistributedArray_wrp
CONTAINS
  !> Wraps distributed array constructor.
  !! @param[inout] ih_this array to construct.
  !! @param[in] length the size of the array.
  SUBROUTINE ConstructDistributedArray_wrp(ih_this, length) &
       & bind(c,name="ConstructDistributedArray_wrp")
    INTEGER(kind=c_int), INTENT(inout) :: ih_this(SIZE_wrp)
    INTEGER(kind=c_int), INTENT(in) :: length
    TYPE(DistributedArray_wrp) :: h_this

    ALLOCATE(h_this%data)
    CALL ConstructDistributedArray(h_this%data, length)
    ih_this = TRANSFER(h_this,ih_this)
  END SUBROUTINE ConstructDistributedArray_wrp
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  !> Set a value in the distributed array.
  !! @param[inout] ih_this the array to set.
  !! @param[in] index_point (global) index of the value.
  !! @param[in] value_point value to set.
  SUBROUTINE SetDistributedArrayAt_wrp(ih_this, index_point, value_point) &
       & bind(c,name="SetDistributedArrayAt_wrp")
    INTEGER(kind=c_int), INTENT(inout) :: ih_this(SIZE_wrp)
    INTEGER(kind=c_int), INTENT(in) :: index_point
    REAL(kind=c_double), INTENT(in) :: value_point
    TYPE(DistributedArray_wrp) :: h_this

    h_this = TRANSFER(ih_this,h_this)
    CALL SetDistributedArrayAt(h_this%data,index_point, value_point)
  END SUBROUTINE SetDistributedArrayAt_wrp
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  !> Sum up the values in the array.
  !! @param[inout] ih_this the array to set.
  !! @result = sum(this)
  FUNCTION SumDistributedArray_wrp(ih_this) RESULT(sum_value) &
       & bind(c,name="SumDistributedArray_wrp")
    INTEGER(kind=c_int), INTENT(inout) :: ih_this(SIZE_wrp)
    REAL(kind=c_double) :: sum_value
    TYPE(DistributedArray_wrp) :: h_this

    h_this = TRANSFER(ih_this,h_this)
    sum_value = SumDistributedArray(h_this%data)
  END FUNCTION SumDistributedArray_wrp
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  !> Destruct the distributed array.
  !! @param[inout] ih_this the array to destroy.
  SUBROUTINE DestructDistributedArray_wrp(ih_this) &
       & bind(c,name="DestructDistributedArray_wrp")
    INTEGER(kind=c_int), INTENT(inout) :: ih_this(SIZE_wrp)
    TYPE(DistributedArray_wrp) :: h_this

    h_this = TRANSFER(ih_this,h_this)
    CALL DestructDistributedArray(h_this%data)
    DEALLOCATE(h_this%data)
  END SUBROUTINE DestructDistributedArray_wrp
END MODULE DistributedArrayModule_wrp
