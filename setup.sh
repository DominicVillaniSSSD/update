#!/bin/bash
# Define color variables for echo commands
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
DARK_GREEN='\033[0;32;2m'
NC='\033[0m' # No Color

# Usage example:
# echo -e "${RED}This text is red${NC}"

# Function to check machine architecture and install Rosetta if needed
check_architecture() {
    ARCH=$(uname -m)
    if [[ "$ARCH" == "arm64" ]]; then
        echo -e "${GREEN}This Mac is running on Apple Silicon.${NC}"
        # Check if Rosetta 2 is already installed
        if /usr/bin/pgrep oahd >/dev/null 2>&1; then
            echo -e "${GREEN}Rosetta 2 is already installed.${NC}"
        else
            echo -e "${GREEN}Installing Rosetta 2...${NC}"
            softwareupdate --install-rosetta --agree-to-license
        fi
    elif [[ "$ARCH" == "x86_64" ]]; then
        echo -e "${GREEN}This Mac is running on Intel. No need for Rosetta.${NC}"
    else
        echo -e "${RED}Unknown architecture: $ARCH${NC}"
        exit 1
    fi
}

# Checks to see what version of macOS is running on the device
check_macos_version() {
    OS_VERSION=$(sw_vers -productVersion)
    if [[ "$OS_VERSION" == 14.* ]]; then
        echo -e "${GREEN}You are running macOS Sonoma${NC}"
    elif [[ "$OS_VERSION" == 13.* ]]; then
        echo -e "${GREEN}You are running macOS Ventura${NC}"
    elif [[ "$OS_VERSION" == 12.* ]]; then
        echo -e "${GREEN}You are running macOS Monterey${NC}"
    elif [[ "$OS_VERSION" == 11.* ]]; then
        echo -e "${RED}You are running macOS Big Sur${NC}"
    elif [[ "$OS_VERSION" == 10.15.* ]]; then
        echo -e "${RED}You are running macOS Catalina${NC}"
    elif [[ "$OS_VERSION" == 10.14.* ]]; then
        echo -e "${RED}You are running macOS Mojave wich isn't compatible with this script.${NC}"
    elif [[ "$OS_VERSION" == 10.13.* ]]; then
        echo -e "${RED}You are running macOS High Sierra wich isn't compatible with this script.${NC}"
    elif [[ "$OS_VERSION" == 10.12.* ]]; then
        echo -e "${RED}You are running macOS Sierra wich isn't compatible with this script.${NC}"
    elif [[ "$OS_VERSION" == 10.11.* ]]; then
        echo -e "${RED}You are running macOS El Capitan wich isn't compatible with this script.${NC}"
    elif [[ "$OS_VERSION" == 10.10.* ]]; then
        echo -e "${RED}You are running macOS Yosemite wich isn't compatible with this script.${NC}"
    else
        echo -e "${RED}You are running an incompatible version of macOS.${NC}"
    fi
}

