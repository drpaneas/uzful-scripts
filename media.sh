#!/bin/bash

# Modify system repositories (add packman)
zypper ar -f -n packman http://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Leap_42.1/ packman

# Refresh system repositories
zypper ref

# Install packages (codecs/multimedia)
zypper in fdupes ffmpeg flash-player gstreamer gstreamer-0_10 gstreamer-0_10-lang gstreamer-0_10-plugin-gnomevfs gstreamer-0_10-plugins-base gstreamer-0_10-plugins-base-lang gstreamer-lang gstreamer-plugins-bad gstreamer-plugins-bad-lang gstreamer-plugins-bad-orig-addon gstreamer-plugins-base gstreamer-plugins-base-lang gstreamer-plugins-good gstreamer-plugins-good-lang gstreamer-plugins-ugly gstreamer-plugins-ugly-lang gstreamer-plugins-ugly-orig-addon gstreamer-plugins-vaapi gstreamer-utils k3b k3b-codecs lame libHalf12 libIex-2_2-12 libIlmImf-2_2-22 libIlmThread-2_2-12 liba52-0 libaudclient2 libavcodec56 libavcodec57 libavdevice57 libavfilter6 libavformat56 libavformat57 libavresample3 libavutil54 libavutil55 libchromaprint1 libdca0 libdcadec0 libfaac0 libfaad2 libgstadaptivedemux-1_0-0 libgstallocators-1_0-0 libgstapp-0_10-0 libgstapp-1_0-0 libgstaudio-1_0-0 libgstbadaudio-1_0-0 libgstbadbase-1_0-0 libgstbadvideo-1_0-0 libgstbasecamerabinsrc-1_0-0 libgstcodecparsers-1_0-0 libgstfft-1_0-0 libgstgl-1_0-0 libgstinterfaces-0_10-0 libgstmpegts-1_0-0 libgstpbutils-1_0-0 libgstphotography-1_0-0 libgstreamer-0_10-0 libgstreamer-1_0-0 libgstriff-1_0-0 libgstrtp-1_0-0 libgstrtsp-1_0-0 libgstsdp-1_0-0 libgsttag-1_0-0 libgsturidownloader-1_0-0 libgstvideo-1_0-0 libgstwayland-1_0-0 libmad0 libmjpegutils-2_0-0 libmp3lame0 libmpeg2-0 libmpg123-0 libopencore-amrnb0 libopencore-amrwb0 libopencv3_1 libpostproc53 libpostproc54 libquicktime0 librtmp1 libshine3 libsoxr0 libswresample1 libswresample2 libswscale3 libswscale4 libtwolame0 libtxc_dxtn libvlc5 libvlccore8 libvo-aacenc0 libvo-amrwbenc0 libx264-148 libx265-79 libxmmsclient6 libxvidcore4 mjpegtools phonon-backend-vlc phonon4qt5-backend-vlc typelib-1_0-Gst-1_0 typelib-1_0-GstAudio-1_0 typelib-1_0-GstPbutils-1_0 typelib-1_0-GstTag-1_0 typelib-1_0-GstVideo-1_0 vlc vlc-codecs vlc-noX vlc-noX-lang vlc-qt xboard

# Perform a distribution upgrade for specific packages (change vendor from system -> packman)
zypper dup --from packman
