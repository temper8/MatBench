SUBROUTINE FIB(A,N)
!
!   CALCULATE FIRST N FIBONACCI NUMBERS
!
   INTEGER N
   REAL*8 A(N)
   DO I=1,N
      IF (I.EQ.1) THEN
         A(I) = 0.5D0
      ELSEIF (I.EQ.2) THEN
         A(I) = 1.0D0
      ELSE 
         A(I) = A(I-1) + A(I-2)
      ENDIF
   ENDDO
END