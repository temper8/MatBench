import numpy as np
import cupy as cp

from benchmark import exec_time

@exec_time()
def create_mat(n):
	A = cp.random.sample((n,n))
	return A

@exec_time()
def inverse(m):
    return cp.linalg.inv(matrix)


@exec_time()
def matmul(m1, m2):
    return cp.matmul(m1, m2)

# Создаем матрицу 2x2
for n in range(100, 10000, 500):
    print("Исходная матрица:\n", n)
    matrix = create_mat(n)
    inv_matrix = inverse(matrix)
    m12 = matmul(matrix, inv_matrix)

    #print("Исходная матрица:\n", n)
    #print("Обратная матрица:\n", n)
    #print("Проверка (A * A⁻¹):\n", n)