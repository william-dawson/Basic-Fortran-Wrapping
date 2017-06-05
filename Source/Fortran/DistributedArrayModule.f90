!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!> A distributed array module.
MODULE DistributedArrayModule
  USE mpi
  USE iso_c_binding
  IMPLICIT NONE
  PRIVATE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  !> A datatype that wraps distributed dynamic arrays.
  TYPE, PUBLIC :: DistributedArray_t
     !> Actual data
     REAL(c_double), DIMENSION(:), ALLOCATABLE :: local_data
     !> First index stored locally
     INTEGER :: start_i
     !> Last index stored locally
     INTEGER :: end_i
  END TYPE DistributedArray_t
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  PUBLIC :: ConstructDistributedArray
  PUBLIC :: SetDistributedArrayAt
  PUBLIC :: SumDistributedArray
  PUBLIC :: DestructDistributedArray
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
CONTAINS
  !> Construct a distributed array.
  !! @param[inout] this the array to construct.
  !! @param[in] length the size of the array.
  SUBROUTINE ConstructDistributedArray(this, length)
    !! Parameters
    TYPE(DistributedArray_t), INTENT(inout) :: this
    INTEGER(c_int), INTENT(in) :: length
    !! Local Data
    INTEGER :: process_ranks
    INTEGER :: my_rank
    INTEGER :: local_elements
    INTEGER :: ierr

    !! Compute The Starting/Ending Indices
    CALL MPI_Comm_size(MPI_COMM_WORLD, process_ranks, ierr)
    local_elements = length/process_ranks
    CALL MPI_Comm_rank(MPI_COMM_WORLD, my_rank, ierr)
    this%start_i = local_elements * my_rank + 1
    this%end_i = local_elements * (my_rank + 1)

    IF (my_rank .EQ. process_ranks -1) THEN
       this%end_i = length
       local_elements = this%end_i - this%start_i + 1
    END IF

    !! Allocate
    ALLOCATE(this%local_data(local_elements))
    this%local_data = 0

  END SUBROUTINE ConstructDistributedArray
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  !> Set a value in the distributed array.
  !! @param[inout] this the array to set.
  !! @param[in] index_point (global) index of the value.
  !! @param[in] value_point value to set.
  SUBROUTINE SetDistributedArrayAt(this, index_point, value_point)
    !! Parameters
    TYPE(DistributedArray_t), INTENT(inout) :: this
    INTEGER(c_int) :: index_point
    REAL(c_double)  :: value_point

    IF (index_point .GE. this%start_i .AND. index_point .LE. this%end_i) THEN
       this%local_data(index_point - this%start_i + 1) = value_point
    END IF
  END SUBROUTINE SetDistributedArrayAt
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  !> Sum up the values in the array.
  !! @param[inout] this the array to set.
  !! @result = sum(this)
  FUNCTION SumDistributedArray(this) RESULT(sum_value)
    !! Parameters
    TYPE(DistributedArray_t), INTENT(in) :: this
    REAL(c_double) :: sum_value
    REAL(c_double) :: temp_value
    INTEGER :: ierr

    temp_value = SUM(this%local_data)
    CALL MPI_AllReduce(temp_value,sum_value,1, MPI_DOUBLE, MPI_SUM, &
         & MPI_COMM_WORLD, ierr)
  END FUNCTION SumDistributedArray
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  !> Destruct the distributed array.
  !! @param[inout] this the array to destroy.
  SUBROUTINE DestructDistributedArray(this)
    !! Parameters
    TYPE(DistributedArray_t), INTENT(inout) :: this
    IF (ALLOCATED(this%local_data)) DEALLOCATE(this%local_data)
  END SUBROUTINE DestructDistributedArray
END MODULE DistributedArrayModule
