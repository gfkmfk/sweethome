#!/bin/sh

promptyn () {
    while true; do
        read -p "$1 " yn
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

if promptyn "is the sky blue?"; then
    echo "yes"
else
    echo "no"
fi
