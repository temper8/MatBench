program solve
!     .. Parameters ..
	INTEGER          N, NRHS
	PARAMETER        ( N = 10000, NRHS = 2 )
	INTEGER          LDA, LDB
	PARAMETER        ( LDA = N, LDB = N )



	
!     .. Local Scalars ..
	INTEGER          INFO
	
!     .. Local Arrays ..
	INTEGER          IPIV( N )
!		  COMPLEX          A( LDA, N ), B( LDB, NRHS )
	complex, dimension (:,:), allocatable :: A
	complex, dimension (:), allocatable :: R	
	complex, dimension(LDB,N) :: B	

	!real(8), dimension (:,:), allocatable :: A
	!real(8), dimension (:), allocatable :: R	
	!real(8), dimension(LDB,N) :: B	

	integer, dimension( 4 )  ::	ISEED

	INTEGER :: c1,c2,cr,cm, i
     real    ::  T1,T2 ,rate 
     real    ::  dt1, dt2, dt3 
	 real sys_clock
     real, dimension(2) :: tarray
     real :: result

	 CALL system_clock(count_rate=cr)
	 CALL system_clock(count_max=cm)
	 rate = REAL(cr)
	 WRITE(*,*) "system_clock rate ",rate


	 allocate ( A(N,N) )
	 
	 allocate ( R(N) )
     print *, 'Hello, matmul'
     print *, "         n", "      init","         parallel", "     no-parallel"
     !do nn = 100, 2500, 100
     call cpu_time(T1)  
	!call dlarnv	(1, ISEED, N,	A )	
	!call dlarnv	(1, ISEED, N,	R )	
	call clarnv	(1, ISEED, N,	A )	
	call clarnv	(1, ISEED, N,	R )	

	print *, "1"
	do i = 1,N
     B(1,i) = R(i)    
	 B(2,i) = R(i)
	end do 
	print *, "2"
     call cpu_time(T2)
     dt1 = T2-T1

	 CALL SYSTEM_CLOCK(c1)	
	 call cpu_time(T1) 
!   Solve the equations A*X = B.

	CALL CGESV( N, NRHS, A, LDA, IPIV, B, LDB, INFO )
!	CALL CGESV( N, NRHS, A, LDA, IPIV, B, LDB, INFO )
       
	call cpu_time(T2)
	CALL SYSTEM_CLOCK(c2)	
	dt3 = T2-T1
	sys_clock = (c2 - c1)/rate

	print *, dt3, sys_clock
     !print *, sum(c) 
     print *,"end"
end program solve