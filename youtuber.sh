#!/bin/bash
echo What is the artist of the song?
read ARTIST 
echo What is the name of the song?
read NAME
youtube-dl --extract-audio --audio-format mp3 "ytsearch:$ARTIST $NAME album version" 
