#!/bin/bash
#Script based on official FFMPEG Compilation Guide at https://ffmpeg.org/trac/ffmpeg/wiki/UbuntuCompilationGuide
#This is ONLY for Ubuntu 13.04
intro()
{
	clear
	echo "FFMPEG Compilation Guide"
	echo
}

get_dependencies()
{
	echo -e "\e[1;32mChecking dependecies\e[0m"
	sudo apt-get -y update
	echo
	echo -e "\e[1;32mInstalling required packages\e[0m"
	sudo apt-get -y install autoconf automake build-essential git libass-dev libgpac-dev libsdl1.2-dev libtheora-dev libtool libva-dev libvdpau-dev libvorbis-dev libx11-dev libxext-dev libxfixes-dev pkg-config texi2html zlib1g-dev
	echo
	echo -e "\e[1;32mCreate folder called 'ffmpeg_sources'\e[0m"
	mkdir ~/ffmpeg_sources
}

yasm()
{
	echo -e "\e[1;32mDownload and install Yasm\e[0m"
	sudo apt-get install -y yasm
}

x264()
{
	echo
	echo -e "\e[1;32mDownload x264 source code from GitHub\e[0m"
	cd ~/ffmpeg_sources
	git clone --depth 1 git://git.videolan.org/x264.git
	cd x264
	echo
	echo -e "\e[1;32mMake x264\e[0m"
	./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" --enable-static
	make
	echo
	echo -e "\e[1;32mMake install x264\e[0m"
	make install
	echo
	echo -e "\e[1;32mMake distclean\e[0m"
	make distclean
}

AAC()
{
	echo
	echo -e "\e[1;32mDownload fdk-acc source code from GitHub\e[0m"
	cd ~/ffmpeg_sources
	git clone --depth 1 git://github.com/mstorsjo/fdk-aac.git
	cd fdk-aac
	autoreconf -fiv
	echo
	echo -e "\e[1;32mConfigure fdk-acc\e[0m"
	./configure --prefix="$HOME/ffmpeg_build" --disable-shared
	echo
	echo -e "\e[1;32mMake fdk-acc\e[0m"
	make
	echo
	echo -e "\e[1;32mMake install fdk-acc\e[0m"
	make install
	echo
	echo -e "\e[1;32mMake distclean\e[0m"
	make distclean
}

MP3()
{
	echo
	echo -e "\e[1;32mDownload and install Lame Mp3\e[0m"
	sudo apt-get -y install libmp3lame-dev
}

Opus()
{
	echo
	echo -e "\e[1;32mDownload and install Opus\e[0m"
	sudo apt-get install -y libopus-dev
}

WebM()
{
	echo
	echo -e "\e[1;32mDownload and install WebM\e[0m"
	sudo apt-get install -y libvpx-dev 
}

ffmpeg()
{
	echo
	echo -e "\e[1;32mDownload FFMPEG source code from GitHub\e[0m"
	cd ~/ffmpeg_sources
	git clone --depth 1 git://source.ffmpeg.org/ffmpeg
	cd ffmpeg
	echo
	echo -e "\e[1;32mConfigure FFMPEG\e[0m"
	./configure --prefix="$HOME/ffmpeg_build" --extra-cflags="-I$HOME/ffmpeg_build/include" \
	  --extra-ldflags="-L$HOME/ffmpeg_build/lib" --bindir="$HOME/bin" --extra-libs="-ldl" --enable-gpl \
	  --enable-libass --enable-libfdk-aac --enable-libmp3lame --enable-libopus --enable-libtheora \
	  --enable-libvorbis --enable-libvpx --enable-libx264 --enable-nonfree --enable-x11grab
	echo
	echo -e "\e[1;32mMake FFMPEG\e[0m"
	make
	echo
	echo -e "\e[1;32mMake Install FFMPEG\e[0m"
	make install
	echo
	echo -e "\e[1;32mLink FFMPEG TO /usr/local/bin directory\e[0m"
	sudo cp ffmpeg /usr/local/bin/
	sudo ldconfig
	echo
	echo -e "\e[1;32mChange permission\e[0m"
	sudo chmod 755 $path
	echo
	echo -e "\e[1;32mMake distclean\e[0m"
	#make distclean
	hash -r
}

check_version()
{
	path=`whereis ffmpeg | awk '{ print $2 }'`;

	test="$path -version"
	$test > checkarisma
	
	if grep --quiet git checkarisma; then 
		echo -e "\e[1;32mFFMPEG (GitHub Official version) has been already installed. What do you want to do?\e[0m"
		echo -e "\e[1;32m 1. Upgrade and recompile FFMPEG\e[0m"
	    echo -e "\e[1;32m 2. Remove and uninstall all FFMPEG resources\e[0m"
	    echo -e "\e[1;32m 3. Quit\e[0m"
	    echo -e "Answer: (1, 2 or 3)"
	    read answer
	    case $answer in
	            1) upgrade_all;;
				2) remove_all;;
				3) exit;;
				*) echo "invalid option. Exit...";;
		esac
	else
		echo -e "\e[1;32mFAKE FFMPEG version or corrupted installation detected!!!\e[0m"
		echo -e "\e[1;32m 1. Fix the problem and compile/install the official FFMPEG\e[0m"
	    echo -e "\e[1;32m 2. Quit\e[0m"
	    echo -e "Answer: (1 or 2)"
	    read answer
	    case $answer in
	    	1) remove_fake;;
			2) exit;;
			*) echo "invalid option. Exit...";;
		esac

	fi
	rm checkarisma
}

compile_ffmpeg()
{
	get_dependencies
	yasm
	x264
	AAC
	MP3
	Opus
	WebM
	ffmpeg
}

remove_all()
{
	rm -rf ~/ffmpeg_build ~/ffmpeg_sources ~/bin/{ffmpeg,ffprobe,ffserver,vsyasm,x264,yasm,ytasm}
	sudo apt-get -y autoremove yasm autoconf automake build-essential git libass-dev libgpac-dev libmp3lame-dev libopus-dev libsdl1.2-dev libtheora-dev libtool libva-dev libvdpau-dev libvorbis-dev libvpx-dev libx11-dev libxext-dev libxfixes-dev texi2html zlib1g-dev
	hash -r

	sudo rm -rf $path
}

upgrade_all()
{
	remove_all
	compile_ffmpeg
}

remove_fake()
{
	sudo apt-get -y autoremove ffmpeg
	remove_all
	compile_ffmpeg
}

#
# Main Program
# Checking if the user has run the script with "sudo" or not
if [ $EUID -ne 0 ] ; then
clear
    echo ""
    echo -e "\e[1;32mCritical Error\e[0m"
    echo "Tip: run the script using sudo command... " 1>&2
    echo ""
    sleep 2
    exit 1
fi


intro

# Checking if FFMPEG is installed or not
is_installed=false;
apt-cache policy ffmpeg > temp
if grep --quiet "Installed" temp; then
	is_installed=true;
fi
rm temp

if $is_installed; then
	# If installed, check for the fake version
	check_version
else
	# if not installed, go for it
	echo -e "\e[1;32mFFMPEG is not installed in your sytem. What do you want?\e[0m"
	echo -e "\e[1;32m 1. Compile and install the official FFMPEG version\e[0m"
	echo -e "\e[1;32m 2. Quit \e[0m "
	echo -e "Answer: (1 or 2)"
	read asnwer
	case $answer in
	    1) compile_ffmpeg;;
		2) exit;;
		*) echo "invalid option. Exit...";;
	esac
fi








