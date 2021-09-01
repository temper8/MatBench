@echo off
call "C:\Program Files (x86)\Intel\oneAPI\setvars.bat" 
python -m numpy.f2py -c fib1.f90 -m fib1  > compile.log
@echo on
echo compile fib1.f90 