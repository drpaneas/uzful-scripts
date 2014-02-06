#!/bin/bash
echo "SimpleCV installation script"
echo "Installing requirements"
sudo apt-get install ipython python-opencv python-scipy python-numpy python-pygame python-setuptools git python-pip
echo "Cloning SimpleCV from GitHub..."
git clone https://github.com/sightmachine/SimpleCV.git -y
cd SimpleCV/
echo "Checking for requirements using pip..."
sudo pip install -r requirements.txt 
echo "Installing  SimpleCV"
sudo python setup.py install
echo "Done! Happy hacking"
