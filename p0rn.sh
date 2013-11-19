#!/bin/bash
echo Copy paste the porn link
read tsonta
dir=$HOME/.porn
if [ ! -d "$dir" ]; then
  mkdir $dir
fi
cd $dir
youtube-dl "$tsonta" 
echo Use the Force wisely
cd ..
