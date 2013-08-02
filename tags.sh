#!/bin/bash

# Matches directory and empty file (tag) names to a list of input strings,
# prints bottom directories containing all input
#
# E.g. finding results from January 2013 in a directory structure
# .
# 2012/
# 2012/01/Simulation/result
# 2013/01/
# 2013/01/Simulation/
# 2013/01/Simulation/result
# 2013/01/Preparation/result
# 2013/02/Simulation/result
#
# $ ./tags.sh 2013 01 result
# .2013/01/Simulation/result
# .2013/01/Preparation/result

# Check if strings partly contain, or match, each other
function match() {
    if [[ "$1" == *"$2"* ]]; then
        MATCH=$1
    elif [[ "$2" == *"$1"* ]]; then
        MATCH=$2
    else
        return 1
    fi

    return 0
}

# Check if FILE $2 substring occurs in TAG $1 results
function control_tags() {
    # If final level, print FILE
    if [ $1 -eq $NUMTAGS ]; then
        echo $2;
    # If not, match against files in TAG and call next if found
    else
        for FILE in ${FOUND[$1]}; do
            if match $2 $FILE; then
                control_tags $(($1+1)) ${MATCH}
            fi
        done
    fi
}

if [ $# == 0 ]; then
    echo USAGE: $0 TAG [TAG [...]]
    exit
fi

NUMTAGS=$#
FOUND={}
i=0

# Find empty files (tags) and directories corresponding to input TAGs
for TAG in $@; do
    DIRS=$(find . -name ${TAG} -type d)
    FILES=$(find . -name ${TAG} -type f -a -empty -printf '%h\n')

    FOUND[$i]=${FILES}${DIRS}
    i=$(($i+1))
done

# Initiate TAG control from TAG results 0
control_tags 0 .
