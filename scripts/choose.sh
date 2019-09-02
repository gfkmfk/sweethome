#!/bin/sh
read -p "Is this a good question (a/b/c/x)? " answer
case ${answer:0} in
    a|A )
        echo "a"
    ;;
    b|B )
        echo "b"
    ;;
    c|C )
        echo "c"
    ;;
    x|X )
        echo "x"
    ;;
    * )
        echo "Incorrect input!"
    ;;
esac
