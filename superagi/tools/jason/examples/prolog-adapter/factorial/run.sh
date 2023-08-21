#!/bin/bash

export PATH="$PATH:/home/andrewdo/swipl-devel/swipl-8.3.9/build/packages/jpl/src/main/java/jpl.jar"

java -cp ".:/usr/lib/swi-prolog/lib/jpl.jar" -Djava.library.path="/usr/local/cuda-8.0/lib64:/usr/local/cuda-8.0/lib64:/usr/java/packages/lib:/usr/lib64:/lib64:/lib:/usr/lib:/usr/lib/swi-prolog/lib:/usr/lib/swi-prolog/lib/x86_64-linux" factorial/Factorial
