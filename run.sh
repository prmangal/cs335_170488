#!/bin/bash
flex p4.l
yacc -d p4.y
gcc lex.yy.c y.tab.c -w

read -p "Enter test file name :" INFILE
if [ ! -f $INFILE ]; then
    echo "ERROR: FIle '$INFILE' is not present!"
    exit -1
fi

OUTFILE="output.txt"

./a.out < $INFILE > $OUTFILE
