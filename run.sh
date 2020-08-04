make clean; make
#find examples -name "*.s" -exec rm -f {} \;

for i in examples/*/*.c
do
    gcc -w -fno-pie -m32 $i #compile with gcc
    ./a.out                 #run it
    expected=$?             #get exit code
    base="${i%.*}"    
    ./nqcc $i 1>/dev/null          #compile with nqcc
    $base                   #run the thing we assembled
    actual=$?               #get exit code
    echo -n "$i:    "
    if [ "$expected" -ne "$actual" ]
    then
        echo "FAIL"
    else
        echo "OK"
    fi
    rm $base
    rm $base.s
done

#cleanup
rm a.out
