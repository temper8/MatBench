module linalg
	real :: rate
contains 
subroutine matmul(a,b,c,n)
	real, dimension (:,:), allocatable ::  a,b,c
	c=0.d0
	do i=1,n         ! Outer loop is parallelized.
	   do j=1,n      ! inner loops are interchanged
		  do k=1,n   ! new inner loop is vectorized 
			 c(j,i)=c(j,i)+a(k,i)*b(j,k)
		  enddo
	   enddo
	enddo
end

subroutine init_system_clock()
	! First initialize the system_clock
	INTEGER :: cr,cm
	CALL system_clock(count_rate=cr)
	CALL system_clock(count_max=cm)
	rate = REAL(cr)
	WRITE(*,*) "system_clock rate ",rate
end	

subroutine init_matrix(a, b, c, n, exec_time)
	real, dimension (:,:), allocatable, intent (in out)  :: a,b,c
	integer, intent (in) :: n
	real :: exec_time
	INTEGER :: c1,c2

	CALL SYSTEM_CLOCK(c1)

	allocate ( a(n,n) )
	allocate ( b(n,n) )
	allocate ( c(n,n) )

	CALL RANDOM_NUMBER(a)
	CALL RANDOM_NUMBER(b)
	CALL SYSTEM_CLOCK(c2)    

	exec_time = (c2 - c1)/rate
end

subroutine matmul_bench(a, b, c, n, exec_time)
	real, dimension (:,:), allocatable, intent (in out)  :: a,b,c
	integer, intent (in) :: n
	real :: exec_time
	INTEGER :: c1,c2

	CALL SYSTEM_CLOCK(c1)

	call matmul(a,b,c,n)

	CALL SYSTEM_CLOCK(c2)    

	exec_time = (c2 - c1)/rate
	
end

end module linalg