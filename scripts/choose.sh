#!/bin/sh
read -p "Is this a good question (a/b/c/x)? " answer
case ${answer:0} in
    a|A )
        echo "a"
        /usr/local/bin/choose.sh
    ;;
    b|B )
        echo "b"
        /usr/local/bin/choose.sh
    ;;
    c|C )
        echo "c"
        /usr/local/bin/choose.sh
    ;;
    x|X )
        echo "x"
        /usr/local/bin/choose.sh
    ;;
    * )
        echo "Incorrect input!"
        /usr/local/bin/choose.sh
    ;;
esac
