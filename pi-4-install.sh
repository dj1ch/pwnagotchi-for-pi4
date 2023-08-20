#!/usr/bin/env bash
echo "### If there are any issues, please submit your issues on my github repository asap!!!!"
echo "### NOTE: YOU MUST HAVE RAN UPDATES, UPGRADED THE PACKAGES, INSTALLED AIRCRACK AND WGET, AND REBOOTED YOUR SYSTEM! CHECK THE INSTALL GUIDE AT https://github.com/jayofelony/pwnagotchi/tree/master"
# Install rtl8812au drivers(only if you need it)
#sudo apt update && sudo apt upgrade -y 
#sudo apt install -y linux-headers-$(uname -r) build-essential bc dkms git libelf-dev rfkill iw
#sudo mkdir ~/rtl-driver
#cd ~/rtl-driver
#git clone https://github.com/morrownr/8812au-20210629.git
#cd 8812au-20210629
#sudo ./install-driver.sh
#cd ~
echo "### This script will take a while. Keep in mind you may need another terminal window for this as you will need to edit some files and run the script at the same time"
echo "### Keep an eye on this screen"
wget "https://github.com/bettercap/bettercap/releases/download/v2.28/bettercap_linux_aarch64_v2.28.zip"
unzip bettercap_linux_aarch64_v2.28.zip
sudo mv bettercap /usr/bin/
sudo bettercap -eval "caplets.update; ui.update; quit"
wget "https://github.com/evilsocket/pwngrid/releases/download/v1.10.3/pwngrid_linux_aarch64_v1.10.3.zip"
unzip pwngrid_linux_aarch64_v1.10.3.zip
sudo mv pwngrid /usr/bin/
sudo pwngrid -generate -keys /etc/pwnagotchi
sudo apt-get update
sudo apt-get -y install gfortran
sudo apt-get -y install libopenmpi-dev
sudo apt-get -y install libdbus-1-dev libdbus-glib-1-dev
sudo apt-get -y install liblapack-dev libhdf5-dev libc-ares-dev libeigen3-dev
sudo apt-get -y install libatlas-base-dev libopenblas-dev libblas-dev
sudo apt-get update
sudo apt-get -y install gfortran
sudo apt-get -y install libopenmpi-dev
sudo apt-get -y install libdbus-1-dev libdbus-glib-1-dev
sudo apt-get -y install liblapack-dev libhdf5-dev libc-ares-dev libeigen3-dev
sudo apt-get -y install libatlas-base-dev libopenblas-dev libblas-dev
sudo echo "deb http://ppa.launchpad.net/deadsnakes/ppa/ubuntu focal main
deb-src http://ppa.launchpad.net/deadsnakes/ppa/ubuntu focal main" >> /etc/apt/sources.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BA6932366A755776
sudo apt-get update
sudo apt-get install -y python3.7 python3.7-dev
sudo python3.7 -m pip install --upgrade pip
sudo python3.7 -m pip install --upgrade wheel
sudo python3.7 -m pip install --upgrade setuptools
python3.7 -m pip install gdown
sudo cp ~/.local/bin/gdown /usr/local/bin/gdown
gdown https://drive.google.com/uc?id=1D9IT2WC2mrWOixsNKohxiJJIlY2IzmQQ
sudo python3.7 -m pip install tensorflow-1.15.0-cp37-cp37m-linux_aarch64.whl
sudo apt-get install gcc-9 gfortran-9
sudo unlink /usr/bin/gcc
sudo ln -s /usr/bin/gcc-9 /usr/bin/gcc
sudo unlink /usr/bin/gfortran
sudo ln -s /usr/bin/gfortran-9 /usr/bin/gfortran
wget "https://github.com/evilsocket/pwnagotchi/archive/v1.5.3.zip"
unzip v1.5.3.zip
cd pwnagotchi-1.5.3
sed -i 's/tensorflow==1.13.1/tensorflow==1.15.0/g' requirements.txt
sed -i 's/tensorflow-estimator==1.14.0/tensorflow-estimator==1.15.1/g' requirements.txt
sudo python3.7 -m pip install -r requirements.txt
sudo python3.7 -m pip install .
sudo systemctl enable bettercap pwngrid-peer pwnagotchi
sudo chmod 755 /usr/bin/bettercap
sudo chown root:root /usr/bin/bettercap
sudo chmod 755 /usr/bin/bettercap-launcher
sudo chmod 755 /usr/bin/pwngrid
sudo chown root:root /usr/bin/pwngrid
sudo chmod 755 /usr/local/bin/pwnagotchi
sudo chown root:root /usr/local/bin/pwnagotchi
sudo chmod 711 /usr/bin/pwnagotchi-launcher
echo "### Please put load your config file now, or make a new one"
echo "### Start Pwnagotchi with the command 'sudo pwnagotchi --manual'"

EOF
