#!/bin/bash

find ../Src/Application/ -iname "*.h" -exec uncrustify -c tufast_uncrustify.cfg --no-backup {} \;
find ../Src/Application/ -iname "*.c" -exec uncrustify -c tufast_uncrustify.cfg --no-backup {} \;
find ../Src/Config/ -iname "*.h" -exec uncrustify -c tufast_uncrustify.cfg --no-backup {} \;
find ../Src/Config/ -iname "*.c" -exec uncrustify -c tufast_uncrustify.cfg --no-backup {} \;
# uncrustify the files provided in the arguments
if [ $# -gt 0 ]; then
    uncrustify -c tufast_uncrustify.cfg --no-backup "$@"
fi