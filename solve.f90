
module utils
  contains
	subroutine PRINT_MATRIX( DESC, M, N, A, LDA )
	  CHARACTER*(*)    DESC
	  INTEGER          M, N, LDA
	  INTEGER          M1, N1
	  COMPLEX          A( LDA, * )
	
	  INTEGER          I, J
	
	  WRITE(*,*)
	  WRITE(*,*) DESC
	  M1 = M
	  N1 = N
	  if (M1>5) M1 = 5
	  if (N1>5) N1 = 5  
	  DO I = 1, M1
		 WRITE(*,9998) ( A( I, J ), J = 1, N1 )
	  END DO
	  
9998 FORMAT( 11(:,1X,'(',F6.2,',',F6.2,')') )
	end  

end module utils

program solve
	use utils
!     .. Parameters ..
	INTEGER          N, NRHS
	PARAMETER        ( NRHS = 1 )
	INTEGER          LDA, LDB

!     .. Local Scalars ..
	INTEGER          INFO
	
!     .. Local Arrays ..
	INTEGER, dimension (:), allocatable ::   IPIV
!		  COMPLEX          A( LDA, N ), B( LDB, NRHS )
	complex, dimension (:,:), allocatable :: A
	complex, dimension (:), allocatable :: R	
	complex, dimension (:,:), allocatable :: B	

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

	 CHARACTER(len=32) :: arg
	 integer stat
     print *, 'Solve the equations A*X = B.'
	 
	 CALL getarg(1, arg)
	 READ(arg,*,iostat=stat)N
	 if (stat<0) then
		print *, "set default size"
		N = 4
	 end if
	 print *, "N=", N 
	 LDA = N
	 LDB = N 

	 ISEED = (/ 1, 2, 3, 4 /)

	 CALL system_clock(count_rate=cr)
	 CALL system_clock(count_max=cm)
	 rate = REAL(cr)
!	 WRITE(*,*) "system_clock rate ",rate

	 allocate ( IPIV(N) )
	 allocate ( A(N,N) )
	 allocate ( B(LDB,NRHS) )
	 allocate ( R(N) )


    call cpu_time(T1)  
	call clarnv	(1, ISEED, N*N,	A )	
	call clarnv	(1, ISEED, N,	R )	

	print *, "1"
	do i = 1,N
     B(i,1) = R(i)    
	! B(i,2) = R(i)
	end do 
	print *, "2"
     call cpu_time(T2)
     dt1 = T2-T1

	 CALL SYSTEM_CLOCK(c1)	
	 call cpu_time(T1) 

	 CALL PRINT_MATRIX( 'A matrix', N, N, A, LDA )

!   Solve the equations A*X = B.

	CALL CGESV( N, NRHS, A, LDA, IPIV, B, LDB, INFO )

	call cpu_time(T2)
	CALL SYSTEM_CLOCK(c2)	
	dt3 = T2-T1
	sys_clock = (c2 - c1)/rate
	print *
	print *, dt3, sys_clock

	IF( INFO.GT.0 ) THEN
		WRITE(*,*)'The diagonal element of the triangular factor of A,'
		WRITE(*,*)'U(',INFO,',',INFO,') is zero, so that'
		WRITE(*,*)'A is singular; the solution could not be computed.'
		STOP
	 END IF

	 CALL PRINT_MATRIX( 'Solution', N, NRHS, B, LDB )
 
	 !print *, sum(c) 
     print *,"end"
end program solve