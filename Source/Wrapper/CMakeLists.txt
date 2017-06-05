set(Wsrc
    DistributedArray_wrp.f90
    WrapperModule.f90
)

add_library(FWWrapper STATIC ${Wsrc})
target_link_libraries(FWWrapper FW)
include_directories(${CMAKE_BINARY_DIR}/Source/Fortran)
