#!/usr/bin/env bash
echo "NOTE: YOU MUST HAVE RAN UPDATES, UPGRADED THE PACKAGES, INSTALLED AIRCRACK AND WGET, AND REBOOTED YOUR SYSTEM! CHECK THE INSTALL GUIDE AT https://github.com/jayofelony/pwnagotchi/tree/master"
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
# Install go-lang
wget https://go.dev/dl/go1.20.6.linux-arm64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.20.6.linux-arm64.tar.gz
sudo nano /etc/profile
export PATH=$PATH:/usr/local/go/bin # Add this line to the bottom
sudo nano ~/.profile
export PATH=$PATH:/usr/local/go/bin # Add this line to the bottom
sudo visudo
:/usr/local/go/bin # Add this to secure_path= line
# Get chip and install nexmon
output=$(dmesg | grep brcm)
sudo apt install raspberrypi-kernel-headers git libgmp3-dev gawk qpdf bison flex make autoconf libtool texinfo gcc-arm-none-eabi wl libfl-dev g++ xxd
cd ~
git clone https://github.com/jayofelony/nexmon.git
cd nexmon
source setup_env.sh
# function to change directories if the file exists
change_dir_if_exists() {
  local file_path="$1"

  if [ -e "$file_path" ]; then
    echo "File found at: $file_path"
    cd "$file_path" || return 1
  else
    echo "File not found at: $file_path"
  fi
}
# changes to file directory
change_dir_if_exists "/patches/$output/9_88_4_65/nexmon"
change_dir_if_exists "/patches/$output/7_45_41_26/nexmon"
change_dir_if_exists "/patches/$output/7_120_5_1_sta_C0/nexmon"
make
make backup-firmware
make install-firmware
cd utilities/nexutil/
make && make install
iw phy `iw dev wlan0 info | gawk '/wiphy/ {printf "phy" $2}'` interface add mon0 type monitor
iw phy `iw dev wlan0 info | gawk '/wiphy/ {printf "phy" $2}'` interface add mon0 type monitor
tcpdump -i mon0
sudo apt install raspberrypi-kernel-headers git libgmp3-dev gawk qpdf bison flex make autoconf libtool texinfo gcc-arm-none-eabi wl libfl-dev g++ xxd
cd ~
git clone https://github.com/jayofelony/nexmon.git
cd nexmon
# set dependancies and install
cat > /tmp/dependencies << EOF
aircrack-ng
time
rsync
vim
wget
screen
git
build-essential
dkms
python3-pip  
python3-smbus
unzip
gawk
libopenmpi-dev
libatlas-base-dev
libelf-dev
libopenjp2-7
libtiff5
tcpdump
lsof
libgstreamer1.0-0
libavcodec58
libavformat58
libswscale5
libusb-1.0-0-dev
libnetfilter-queue-dev
libopenmpi3
dphys-swapfile
libdbus-1-dev 
libdbus-glib-1-dev
liblapack-dev 
libhdf5-dev 
libc-ares-dev 
libeigen3-dev
fonts-dejavu
fonts-dejavu-core
fonts-dejavu-extra
python3-pil
python3-smbus
libfuse-dev
libatlas-base-dev 
libopenblas-dev 
libblas-dev
bc
libgl1-mesa-glx
libncursesw5-dev 
libssl-dev 
libsqlite3-dev 
tk-dev 
libgdbm-dev 
libc6-dev 
libbz2-dev 
libffi-dev 
zlib1g-dev
fonts-freefont-ttf
fbi
python3-flask
python3-flask-cors
python3-flaskext.wtf
EOF

cat /tmp/dependencies | xargs -n5 sudo apt install -y
sudo apt install build-essential libpcap-dev libusb-1.0-0-dev libnetfilter-queue-dev
cd ~
git clone https://github.com/jayofelony/bettercap.git
cd bettercap
sudo make
sudo make install
sudo bettercap -eval "caplets.update; ui.update; quit"
#sudo nano /usr/local/share/bettercap/caplets/pwnagotchi-auto.cap # change iface to wlan0mon
#sudo nano /usr/local/share/bettercap/caplets/pwnagotchi-manual.cap # change iface to wlan0mon
echo "### you need to change the following directories, and change wlan0 to wlan0mon"
echo "### this script will not be able to change it"
echo "'### /usr/local/share/bettercap/caplets/pwnagotchi-auto.cap'"
echo "'### /usr/local/share/bettercap/caplets/pwnagotchi-manual.cap'"
echo "### you will need to open another terminal tab or ssh in another window to do so"
# Function to ask the user to continue or exit
ask_to_continue() {
  read -p "Did you edit the files? (Y/N)? " response
  case "$response" in
    [yY]) 
      echo "Continuing..."
      ;;
    [nN]) 
      echo "Exiting the script..."
      exit 0
      ;;
    *)
      echo "Invalid input. Please enter Y or N."
      ask_to_continue # Ask again if the input is not Y or N
      ;;
  esac
}
# Call the function to ask the user for input
ask_to_continue

cd ~
git clone https://github.com/jayofelony/pwngrid.git
cd pwngrid
sudo make
sudo make install
sudo pwngrid -generate -keys /etc/pwnagotchi
cd ~
# install pwnagotchi
git clone -b pwnagotchi-torch https://github.com/jayofelony/pwnagotchi.git
cd pwnagotchi
for i in $(grep -v ^# requirements.txt | cut -d \> -f 1); do sudo apt -y install python3-$i; done
sudo pip3 install -r requirements.txt
sudo pip3 install .
sudo pip3 install --upgrade numpy
sudo ln -s `pwd`/bin/pwnagotchi /usr/local/bin
sudo ln -s `pwd`/pwnagotchi /usr/local/lib/python3.9/dist-packages/pwnagotchi
sudo mkdir -p /usr/local/share/pwnagotchi/custom-plugins
# make the config
echo "### You will need to make a config.toml"
echo "### Like I have said previously, you will need another terminal/tab for this"
echo "### The file path for the config.toml should be in '/etc/pwnagotchi'. put the file there"
# function asking if they edited the file
ask_to_continue() {
  read -p "Did you edit the config.toml (Y/N)? " response
  case "$response" in
    [yY]) 
      echo "Continuing..."
      ;;
    [nN]) 
      echo "Exiting the script..."
      exit 0
      ;;
    *)
      echo "Invalid input. Please enter Y or N."
      ask_to_continue # Ask again if the input is not Y or N
      ;;
  esac
}

ask_to_continue
for file in `find builder/data -type f`; do
  dest=${file#builder/data}
  if [ -s $dest ]; then
    echo File $dest exists. Skipping
  else
    echo Copying $file to $dest
    sudo cp -p $file $dest
  fi
done
# downgrading pcap
cd ~
wget http://ports.ubuntu.com/pool/main/libp/libpcap/libpcap0.8_1.9.1-3_arm64.deb
wget http://ports.ubuntu.com/pool/main/libp/libpcap/libpcap0.8-dev_1.9.1-3_arm64.deb
wget http://ports.ubuntu.com/pool/main/libp/libpcap/libpcap-dev_1.9.1-3_arm64.deb
sudo apt -y install ./libpcap*.deb  --allow-downgrades
sudo apt-mark hold libpcap-dev libpcap0.8 libpcap0.8-dev
# enabling permissions and rebooting
sudo chmod 755 /usr/local/bin/bettercap
sudo chown root:root /usr/local/bin/bettercap
sudo chmod 755 /usr/bin/bettercap-launcher
sudo chmod 755 /usr/local/bin/pwngrid
sudo chown root:root /usr/local/bin/pwngrid
sudo chmod 755 /usr/local/bin/pwnagotchi
sudo chown root:root /usr/local/bin/pwnagotchi
sudo chmod 711 /usr/bin/pwnagotchi-launcher
sudo chmod 755 /usr/local/share/bettercap/
sudo systemctl enable bettercap pwngrid-peer pwnagotchi bluetooth
sudo sync
ask_to_continue() {
  read -p "Do you want to reboot? (Y/N)? " response
  case "$response" in
    [yY]) 
      echo "Rebooting..."
      ;;
    [nN]) 
      echo "Ok. You will still need to reboot later. "
      exit 0
      ;;
    *)
      echo "Invalid input. Please enter Y or N."
      ask_to_continue # Ask again if the input is not Y or N
      ;;
  esac
}

ask_to_continue
sudo reboot

EOF
