make clean; make
rm assembly.s
./nqcc.byte
gcc -m32 assembly.s -o out  -fno-pie
./out ; echo $?
