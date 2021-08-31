call "C:\Program Files (x86)\Intel\oneAPI\setvars.bat"
echo "test"
python -m numpy.f2py -c fib1.f90 -m fib1