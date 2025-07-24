#!/usr/bin/env sh

./buildPrivate.sh

fswatch -o assets/ trees/ | while read num ; \
  do \
    echo "Rebuilding forest"
    time ./buildPrivate.sh
    echo "Done"
    echo
  done
