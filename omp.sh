ifort solve.f90 -I${MKLROOT}/include/intel64/ilp64 -i8  -I"${MKLROOT}/include" \
 ${MKLROOT}/lib/intel64/libmkl_blas95_ilp64.a ${MKLROOT}/lib/intel64/libmkl_lapack95_ilp64.a -Wl,--start-group \
 ${MKLROOT}/lib/intel64/libmkl_intel_ilp64.a \
 ${MKLROOT}/lib/intel64/libmkl_sequential.a \
 ${MKLROOT}/lib/intel64/libmkl_core.a -Wl,--end-group -lpthread -lm -ldl