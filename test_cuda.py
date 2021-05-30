import cupy as cp
from benchmark import exec_time

@exec_time()
def create_mat(n):
	A = cp.random.sample((n,n))
	B = cp.random.sample((n,n))
	return (A,B)

@exec_time()
def mult_mat(A,B):
	return cp.dot(A,B)

n = 9000
print(f"numpy mult test N={n}")

(a,b) = create_mat(n)
c = mult_mat(a,b)
#print(c)