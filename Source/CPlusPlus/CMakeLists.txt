set(CPlusPlussrc
    DistributedArray.cc DistributedArray.h
)

include_directories(${CMAKE_SOURCE_DIR}/Source/C)
add_library(FWCPP STATIC ${CPlusPlussrc})
target_link_libraries(FWCPP FWWrapper)
