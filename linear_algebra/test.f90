program test
    use linalg

    real, dimension (:,:), allocatable :: a,b,c
    integer :: n
    real :: exec_time
    n = 10000

    call  init_system_clock()

    call init_matrix(a, b, c, n, exec_time)

    print *, exec_time

    call matmul_bench(a, b, c, n, exec_time)

    print *, exec_time

end program test