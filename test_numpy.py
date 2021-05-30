import numpy as np 


def create_mat(n):
	A = np.random.sample((n,n))
	B = np.random.sample((n,n))
	return (A,B)

def mult_mat(A,B):
	return np.dot(A,B)


print("numpy test")

(a,b) = create_mat(3)
c = mult_mat(a,b)
print(c)