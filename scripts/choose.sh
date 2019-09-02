#!/bin/sh
read -p "Is this a good question (y/n)? " answer
case ${answer:0:1} in
    y|Y )
        echo "Yes"
    ;;
    n|N )
        echo "No"
    ;;
    * )
        echo "Incorrect input!"
    ;;
esac
