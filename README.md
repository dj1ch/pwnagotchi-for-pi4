# WARNING: NOT FULLY WORKING YET!!!!!!
# pwnagotchi for pi4 install script
This script is going to help you by installing everything you need to install pwnagotchi.

### Note
Not everything is fully automated since this script only installs the packages you need. The script will stop a couple of times for you to edit the configs. Keep in mind you will need to re-ssh into the pi4 again to do this. 

https://pwnagotchi.ai/

# Prerequisites
- You have to install aircrack and wget, then reboot your system afterward
  
`sudo apt-get update`

`sudo apt-get dist-upgrade`

`sudo apt-get install -y aircrack-ng wget`

`sudo reboot`

# FAQ

## How do I run the script?
`cd pwnagotchi-for-pi4`

`sudo bash pi-4-install.sh`

## What do I do after installing?
The script has now reached a point where everything mentioned here has already been done if you followed the script. I would likely reboot your pi after it has finished. 

`sudo reboot`

### Note
This script is not fully working yet. Any help will be appreciated. 
