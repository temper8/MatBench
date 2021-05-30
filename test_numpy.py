import numpy as np 
from benchmark import exec_time

@exec_time()
def create_mat(n):
	A = np.random.sample((n,n))
	B = np.random.sample((n,n))
	return (A,B)

@exec_time()
def mult_mat(A,B):
	return np.dot(A,B)

n = 15000
print(f"numpy mult test N={n}")

(a,b) = create_mat(n)
c = mult_mat(a,b)
#print(c)