#!/bin/bash
# Modified by Panos Georgiadis
# Author: drpaneas@gmail.com
# Date: 27/02/2013
# License Artistic License 2.0


intro()
{ clear
echo " ______________________________________________________"
echo " Use this script instead of reading the manual "
echo "|______________________________________________________|"
echo
}

audio()
{
# Πέτα πάλι την εισαγωγή
intro

echo "Which audio interface you want to use?"
echo
echo "1. ALSA - Advanced Linux Sound Architecture"
echo "2. Pulse Audio"
echo
echo "Answer:"
read answer

case $answer in
        1) audio_interface="-f alsa -i hw:1,0";;
2) audio_interface="-f alsa -i pulse";;
3) exit;;
*) echo "invalid option. Exit...";;
    esac
}

audio_codec()
{
# Πέτα πάλι την εισαγωγή
intro

echo "Which audio codec you'd like to use ?"
echo
echo "1. Lossless"
echo "2. mp3 Lame"
echo "3. ACC Stereo HQ"
echo "4. ACC Stereo 5.1 HQ"
echo
echo "Answer:"
read answer

case $answer in
        1) audiocodec="pcm_s16le -ar 44100 -ac 2";;
2) audiocodec="libmp3lame -ab 128k -ac 2";;
3) audiocodec="libfaac -ac 2 -ar 48000 -ab 192k";;
4) audiocodec="-acodec libfaac -ac 6 -ar 48000 -ab 448k";;
5) exit;;
*) echo "invalid option. Exit...";;
    esac
}

video_codec()
{
# Πέτα πάλι την εισαγωγή
intro

echo "Which video codec you'd like to use?"
echo
echo "1. H.264"
echo "2. MPEG2"
echo "3. MPEG4"
echo
echo "Answer:"
read answer

case $answer in
        1) videocodec="libx264 -preset ultrafast -qp 0";;
2) videocodec="mpeg2video -qscale:v 0";;
3) videocodec="mpeg4 -b 1200kb";;
3) exit;;
*) echo "invalid option. Exit...";;
    esac
}



# Αρχίζει η λειτουργία του script

# πέταξε το εισαγωγικό μύνημα
intro

# Περίμενε 2 sec να το διαβαζει
sleep 2

# Επέλεξε audio interface που θα κανει capture
audio

# Επέλεξε κωδικοποιητή ήχου
audio_codec

# Επέλεξε κωδικοποιητή video
video_codec

# Επέλεξε ανάλυση
resolution=`xdpyinfo | grep 'dimensions:' | awk '{print $2}'`

intro
echo "According to the manual, the command you need is:"
echo
echo "ffmpeg $audio_interface -f x11grab -s $resolution -i :0.0 -c:a $audiocodec -c:v $videocodec file.avi"
