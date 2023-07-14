#!/usr/bin/env bash
# NOTE: YOU MUST HAVE RAN UPDATES, UPGRADED THE PACKAGES,
# INSTALLED AIRCRACK AND WGET, AND REBOOTED YOUR SYSTEM!
# CHECK THE INSTALL GUIDE AT https://github.com/jayofelony/pwnagotchi/tree/master
# Bettercap install
git clone https://github.com/bettercap/bettercap.git
cd bettercap
sudo make build
sudo make install
sudo bettercap -eval "caplets.update; ui.update; quit"
# Pwngrid install(pre-compiled)
wget https://github.com/evilsocket/pwngrid/releases/download/v1.10.3/pwngrid_linux_aarch64_v1.10.3.zip
unzip pwngrid_linux_aarch64_v1.10.3.zip
sudo mv pwngrid /usr/bin/
sudo pwngrid -generate -keys /etc/pwnagotchi
# More dependencies
sudo apt-get -y install gfortran libopenmpi-dev libdbus-1-dev libdbus-glib-1-dev liblapack-dev libhdf5-dev libc-ares-dev libeigen3-dev libatlas-base-dev libopenblas-dev libblas-dev
# Python building + updating
sudo apt-get install -y build-essential checkinstall pkg-config libfreetype6-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev
cd /usr/src
sudo wget https://www.python.org/ftp/python/3.7.9/Python-3.7.9.tgz
sudo tar xzf Python-3.7.9.tgz
cd Python-3.7.9
sudo ./configure --enable-optimizations
sudo make altinstall
sudo python3.7 -m pip install setuptools==65.5.0 pip==21
sudo python3.7 -m pip install --upgrade wheel
# Tensorflow download + install
sudo python3.7 -m pip install tensorflow
# Libpcap install
wget http://old.kali.org/kali/pool/main/libp/libpcap/libpcap0.8_1.9.1-4_arm64.deb
sudo dpkg -i libpcap0.8_1.9.1-4_arm64.deb
# Pwnagotchi compiling
git clone https://github.com/jayofelony/pwnagotchi.git
cd pwnagotchi
sudo python3.7 -m pip install -r requirements.txt
sudo python3.7 -m pip install .
# Permission error fixes
sudo chown root:root /usr/bin/bettercap
sudo chmod 755 /usr/bin/bettercap-launcher
sudo chmod 755 /usr/bin/pwngrid
sudo chown root:root /usr/bin/pwngrid
sudo chmod 755 /usr/local/bin/pwnagotchi
sudo chown root:root /usr/local/bin/pwnagotchi
sudo chmod 711 /usr/bin/pwnagotchi-launcher
# Enable services
sudo systemctl enable bettercap pwngrid.peer.service pwnagotchi bluetooth
echo "from here you will need to edit the following files: /etc/systemd/system/pwngrid-peer.service ; /usr/local/share/bettercap/caplets/pwnagotchi-auto.cap ; /usr/local/share/bettercap/caplets/pwnagotchi-auto.cap"
echo "change mon0 to wlan0mon"
echo "then you will need to load or edit your config.toml file for the pwnagotchi"
echo "the location of the config.toml should be in /etc/pwnagotchi"
