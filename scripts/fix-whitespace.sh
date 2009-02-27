#!/bin/bash

case $# in
    1)
        find $1 -type f -name '*.as' \
            -exec dos2unix --d2u '{}' ';' \
            -exec emacs -batch '{}' \
              -f delete-trailing-whitespace \
              -f save-buffer ';'
        ;;
    *)
        echo "usage: $0 ROOT-DIRECTORY" ;;
esac
