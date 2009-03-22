#!/bin/bash

case $# in
    1)
        find $1 -type f -name '*.as' \
          -exec perl -i -0777 -p \
            -e 's/[ \t]*\r?\n/\n/g;' \
            -e 's/(\r?\n)*\Z/\n/;' \
              '{}' ';'
        ;;
    *)
        echo "usage: $0 ROOT-DIRECTORY" ;;
esac
