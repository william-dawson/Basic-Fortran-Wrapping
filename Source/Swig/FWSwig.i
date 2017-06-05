%module FWSwig
%include "typemaps.i"
%{
#include "DistributedArray.h"
using namespace FW;
%}

%include "DistributedArray.h"
