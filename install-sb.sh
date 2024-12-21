#!/bin/bash

# Functions
print_info() {
    echo -e "\033[1;32m[INFO]\033[0m $1"
}

print_error() {
    echo -e "\033[1;31m[ERROR]\033[0m $1"
}

# Check for root privileges
if [[ $EUID -ne 0 ]]; then
    print_error "Please run this script as root or using sudo."
    exit 1
fi

# System update
print_info "Updating the system..."
apt-get update -y || { print_error "Failed to update the system."; exit 1; }

# Install Python
print_info "Installing Python..."
apt-get install -y python || { print_error "Failed to install Python."; exit 1; }

# Clone Gemail-Hack
print_info "Cloning the Gemail-Hack repository..."
if [ ! -d "Gemail-Hack" ]; then
    git clone https://github.com/Ha3MrX/Gemail-Hack.git || { print_error "Failed to clone Gemail-Hack."; exit 1; }
else
    print_info "Gemail-Hack already exists. [✔]"
fi

# Facebook setup
print_info "Setting up the Facebook directory..."
if [ ! -d "facebook" ]; then
    mkdir facebook
    cd facebook || exit 1
    wget -q https://raw.githubusercontent.com/Sup3r-Us3r/scripts/master/fb-brute.pl || { print_error "Failed to download fb-brute.pl."; exit 1; }
    cd .. || exit 1
else
    print_info "Facebook directory already exists. [✔]"
fi

# Clone and configure Instainsane
print_info "Cloning and configuring Instainsane..."
if [ ! -d "instainsane" ]; then
    git clone https://github.com/thelinuxchoice/instainsane.git || { print_error "Failed to clone Instainsane."; exit 1; }
fi
cd instainsane || exit 1
chmod +x instainsane.sh install.sh
./install.sh || { print_error "Failed to install Instainsane."; exit 1; }
cd .. || exit 1

# Clone and configure TweetShell
print_info "Cloning and configuring TweetShell..."
if [ ! -d "tweetshell" ]; then
    git clone https://github.com/thelinuxchoice/tweetshell.git || { print_error "Failed to clone TweetShell."; exit 1; }
fi
cd tweetshell || exit 1
chmod +x tweetshell.sh install.sh
./install.sh || { print_error "Failed to install TweetShell."; exit 1; }
cd .. || exit 1

print_info "Script completed successfully! Everything is configured properly."
