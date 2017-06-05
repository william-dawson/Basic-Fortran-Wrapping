!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!> Test The Distributed Array In Fortran.
PROGRAM TestDistributedArray
  USE DistributedArrayModule
  USE iso_c_binding
  USE mpi
  IMPLICIT NONE
  !! Parameter processing
  CHARACTER(len=80) :: argument
  INTEGER           :: matrix_length
  INTEGER           :: values_to_add
  !! MPI
  INTEGER :: ierr
  !! Local Data
  INTEGER :: my_rank
  REAL(c_double) :: sum_value
  REAL(c_double) :: temporary
  TYPE(DistributedArray_t) :: DA
  !! Temporary Variables
  REAL(c_double) :: next_value
  INTEGER :: next_location
  INTEGER :: counter

  CALL MPI_Init( ierr )
  CALL MPI_Comm_rank(MPI_COMM_WORLD, my_rank, ierr)

  !! Process Parameters
  DO counter=1,command_argument_count(),2
     CALL get_command_argument(counter,argument)
     SELECT CASE(argument)
     CASE("--matrix_length")
        CALL get_command_argument(counter+1,argument)
        READ(argument,*) matrix_length
     CASE("--values_to_add")
        CALL get_command_argument(counter+1,argument)
        READ(argument,*) values_to_add
     CASE default
	IF (my_rank .EQ. 0) THEN
           WRITE(*,*) 'Unrecognized command line argument',argument
	END IF
	CALL MPI_Abort(MPI_COMM_WORLD,-1,ierr)
     END SELECT
  END DO

  !! Build and Set
  CALL ConstructDistributedArray(DA,matrix_length)
  next_value = 1.0
  DO counter=1,values_to_add
     CALL RANDOM_NUMBER(temporary)
     next_location = FLOOR(temporary*matrix_length) + 1
     CALL SetDistributedArrayAt(DA,next_location,next_value)
  END DO

  !! Sum and Print
  sum_value = SumDistributedArray(DA)
  IF (my_rank .EQ. 0) THEN
     WRITE(*,*) "Sum value:", sum_value
  END IF

  !! Cleanup
  CALL DestructDistributedArray(DA)
  CALL MPI_Finalize( ierr )
END PROGRAM TestDistributedArray
