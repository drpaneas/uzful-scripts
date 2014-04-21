#!/bin/bash
# Panos Georgiadis (drpaneas@gmail.com)

IFS='
'

FILENAME=$1

movie_function()
{
    echo Type the movie title:
    read TITLE
    echo Type the movie release year:
    read YEAR
    EXT=$(echo $FILENAME | awk -F . '{if (NF>1) {print $NF}}')
    DIR=$(echo "/home/drpaneas/Movies/${TITLE} (${YEAR})")
    mkdir $DIR
    mv $FILENAME "${DIR}/${TITLE} (${YEAR}).${EXT}"
}

tv_function()
{   
    echo Type the TV Series title:
    read TITLE
    echo Type the TV Series season:
    read SEASON
    SEASON=$(echo $SEASON | awk '{$2=sprintf("%02d", $1)}1' | awk '{ print $2}')
    echo Type the number of the episode:
    read EPISODE
    EPISODE=$(echo $EPISODE | awk '{$2=sprintf("%02d", $1)}1' | awk '{ print $2}')
    EXT=$(echo $FILENAME | awk -F . '{if (NF>1) {print $NF}}')
    DIR_BASE=$(echo "/home/drpaneas/TV Shows/${TITLE}")
    mkdir $DIR_BASE 2> /dev/null
    DIR_SEASON=$(echo "/home/drpaneas/TV Shows/${TITLE}/Season ${SEASON}")
    mkdir $DIR_SEASON 2> /dev/null
    echo $FILENAME
    echo $DIR_SEASON
    mv $FILENAME "${DIR_SEASON}/${TITLE} - S${SEASON}E${EPISODE}.${EXT}"
}

echo "Select number: 1 (movie) or 2 (tv) or 0 to Exit"
read TYPE
case $TYPE in
	1) movie_function;;
	2) tv_function;;
	3) exit;;
	*) echo "Are you drunk? Exit...";;
esac
