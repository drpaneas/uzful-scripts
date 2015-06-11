#!/bin/bash

STL_SUB=$1

echo "@ This file written with the Avid Caption plugin, version 1"
echo
echo "<begin subtitles>"

while read line; do
    STARTFRAME=`echo $line | grep "," | awk -F " , " '{ print $1 }'`
    ENDFRAME=`echo $line | grep "," | awk -F " , " '{ print $2 }'`
    STARTFRAME_NO_WHITESPACE="$(echo -e "${STARTFRAME}" | tr -d '[[:space:]]')"
    ENDFRAME_NO_WHITESPACE="$(echo -e "${ENDFRAME}" | tr -d '[[:space:]]')"
    echo $STARTFRAME_NO_WHITESPACE $ENDFRAME_NO_WHITESPACE
    LINE3=$(echo $line | cut -f3- -d',') # From comma to the end of line
    LINE3_NO_EXTERNAL_SPACE="$(echo -e "${LINE3}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
    if $(echo $LINE3 | grep '|' > /dev/null); then
         LINE1=$(echo $LINE3 | awk -F "|" '{ print $1}')
         LINE2=$(echo $LINE3 | awk -F "|" '{ print $2}')
         LINE1_NO_EXTERNAL_SPACE="$(echo -e "${LINE1}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
         LINE2_NO_EXTERNAL_SPACE="$(echo -e "${LINE2}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
         echo -e "$LINE1_NO_EXTERNAL_SPACE\n$LINE2_NO_EXTERNAL_SPACE"
    else
        echo $LINE3_NO_EXTERNAL_SPACE
    fi
    echo
done < $STL_SUB

echo "<end subtitles>"
