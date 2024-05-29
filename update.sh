#!/bin/bash
# Directory to store the scripts
TEMP_DIR="/tmp/update-scripts"

# Create a temporary directory
mkdir -p $TEMP_DIR
cd $TEMP_DIR

# Download necessary scripts
curl -L -o curl.sh https://raw.githubusercontent.com/DominicVillaniSSSD/update/main/curl.sh
curl -L -o install_handlers.sh https://raw.githubusercontent.com/DominicVillaniSSSD/update/main/install_handlers.sh
curl -L -o logo.sh https://raw.githubusercontent.com/DominicVillaniSSSD/update/main/logo.sh
curl -L -o setup.sh https://raw.githubusercontent.com/DominicVillaniSSSD/update/main/setup.sh
# Add more curl commands for additional scripts as needed

# Make the scripts executable
chmod +x curl.sh install_handlers.sh logo.sh setup.sh

# Source or execute the downloaded scripts as needed
source ./curl.sh
source ./install_handlers.sh
source ./logo.sh
source ./setup.sh
# Or use `./script1.sh` and `./script2.sh` if they should be executed in a subshell

# source setup.sh
# source install_handlers.sh
# source curl.sh
# source logo.sh

#Prints logo
print_logo

#Checks architecture
check_architecture

#if [[ "$ARCH" == "arm64" ]]; then
#    zoom_url="$zoom_apple_silicon_url"
#fi

install_applications(){
install_application_from_url "$zoom_url"
install_application_from_url "$smart_notebook_url"
install_application_from_url "$google_chrome_url"
install_application_from_url "$app_cleaner_url"
install_application_from_url "$air_server_url"
install_application_from_url "$crisis_go"
}

install_applications

# Clean up
cd ..
rm -rf $TEMP_DIR
