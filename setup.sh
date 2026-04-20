#!/bin/bash
source curl.sh

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
        zoom_url="$zoom_arm64_url"
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
    if [[ "$OS_VERSION" == 26.* ]]; then
        echo -e "${GREEN}You are running macOS Tahoe${NC}"
        onyx_url="$onyx_tahoe_url"
        word_url="$word_sonoma_url"
        excel_url="$excel_sonoma_url"
        powerpoint_url="$powerpoint_sonoma_url"
        smart_notebook_url="$smart_notebook_25_0_SP1_url"
    elif [[ "$OS_VERSION" == 15.* ]]; then
        echo -e "${GREEN}You are running macOS Sequoia${NC}"
        onyx_url="$onyx_sequoia_url"
        word_url="$word_sonoma_url"
        excel_url="$excel_sonoma_url"
        powerpoint_url="$powerpoint_sonoma_url"
        smart_notebook_url="$smart_notebook_25_0_SP1_url"
    elif [[ "$OS_VERSION" == 14.* ]]; then
        echo -e "${GREEN}You are running macOS Sonoma${NC}"
        onyx_url="$onyx_sonoma_url"
        word_url="$word_ventura_url"
        excel_url="$excel_ventura_url"
        powerpoint_url="$powerpoint_ventura_url"
        smart_notebook_url="$smart_notebook_25_0_SP1_url"
    elif [[ "$OS_VERSION" == 13.* ]]; then
        echo -e "${GREEN}You are running macOS Ventura${NC}"
        onyx_url="$onyx_ventura_url"
        word_url="$word_ventura_url"
        excel_url="$excel_ventura_url"
        powerpoint_url="$powerpoint_ventura_url"
        smart_notebook_url="$smart_notebook_25_0_SP1_url"
    elif [[ "$OS_VERSION" == 12.* ]]; then
        echo -e "${GREEN}You are running macOS Monterey${NC}"
        onyx_url="$onyx_monterey_url"
        word_url="$word_monterey_url"
        excel_url="$excel_monterey_url"
        powerpoint_url="$powerpoint_monterey_url"
        smart_notebook_url="$smart_notebook_24_1_url"
    elif [[ "$OS_VERSION" == 11.* ]]; then
        echo -e "${RED}You are running macOS Big Sur${NC}"
        smart_notebook_url="$smart_notebook22_1_url"
        onyx_url="$onyx_big_sur_url"
        word_url="$word_big_sur_url"
        excel_url="$excel_big_sur_url"
        powerpoint_url="$powerpoint_big_sur_url"
        google_chrome_url="$google_chrome_url_138"
    elif [[ "$OS_VERSION" == 10.15.* ]]; then
        echo -e "${RED}You are running macOS Catalina${NC}"
        #set google chrome url to the 128 bit version
        smart_notebook_url="$smart_notebook22_1_url"
        google_chrome_url="$google_chrome_url_128"
        onyx_url="$onyx_catalina_url"
        word_url="$word_catalina_url"
        excel_url="$excel_catalina_url"
        powerpoint_url="$powerpoint_catalina_url"
    # Mojave and below are not supported 
    #Run cleanup  
    elif [[ "$OS_VERSION" == 10.14.* ]]; then
        echo -e "${RED}You are running macOS Mojave which isn't compatible with this script.${NC}"
        smart_notebook_url="skip"
        google_chrome_url="$google_chrome_url_88"
        onyx_url="$onyx_mojave_url"
        word_url="$word_mojave_url"
        excel_url="$excel_mojave_url"
        powerpoint_url="$powerpoint_mojave_url"
    elif [[ "$OS_VERSION" == 10.13.* ]]; then
        echo -e "${RED}You are running macOS High Sierra which isn't compatible with this script.${NC}"
        smart_notebook_url="skip"
        google_chrome_url="$google_chrome_url_88"
        onyx_url="$onyx_high_sierra_url"
        word_url="$word_high_sierra_url"
        excel_url="$excel_high_sierra_url"
        powerpoint_url="$powerpoint_high_sierra_url"
    elif [[ "$OS_VERSION" == 10.12.* ]]; then
        echo -e "${RED}You are running macOS Sierra which isn't compatible with this script.${NC}"
        smart_notebook_url="skip"
        google_chrome_url="$google_chrome_url_73"
        onyx_url="$onyx_sierra_url"
        word_url="$word_sierra_url"
        excel_url="$excel_sierra_url"
        powerpoint_url="$powerpoint_sierra_url"
    elif [[ "$OS_VERSION" == 10.11.* ]]; then
        echo -e "${RED}You are running macOS El Capitan which isn't compatible with this script.${NC}"
        smart_notebook_url="skip"
        google_chrome_url="$google_chrome_url_73"
        onyx_url="$onyx_el_capitan_url"
        word_url="$word_el_capitan_url"
        excel_url="$excel_el_capitan_url"
        powerpoint_url="$powerpoint_el_capitan_url"
    elif [[ "$OS_VERSION" == 10.10.* ]]; then
        echo -e "${RED}You are running macOS Yosemite which isn't compatible with this script.${NC}"
        smart_notebook_url="skip"
        google_chrome_url="$google_chrome_url_67"
    else
        echo -e "${RED}You are running an incompatible version of macOS.${NC}"
        smart_notebook_url="skip"
        google_chrome_url="skip"
    fi
}

