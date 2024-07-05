#!/bin/bash

# Directory to store the scripts
TEMP_DIR="/tmp/update-scripts"
#delete the temp directory if it exists already so it will not cause errors
rm -rf $TEMP_DIR

# Ensure cleanup on exit
trap 'rm -rf $TEMP_DIR' EXIT

# Create a temporary directory
mkdir -p $TEMP_DIR
cd $TEMP_DIR

# Set the branch
branch="test"

# Download necessary scripts
curl -L -o curl.sh https://raw.githubusercontent.com/DominicVillaniSSSD/update/$branch/curl.sh
curl -L -o install_handlers.sh https://raw.githubusercontent.com/DominicVillaniSSSD/update/$branch/install_handlers.sh
curl -L -o logo.sh https://raw.githubusercontent.com/DominicVillaniSSSD/update/$branch/logo.sh
curl -L -o setup.sh https://raw.githubusercontent.com/DominicVillaniSSSD/update/$branch/setup.sh

source setup.sh
source install_handlers.sh
source curl.sh
source logo.sh

check_macos_version

OS_VERSION=$(sw_vers -productVersion)
if [[ "$OS_VERSION" < "10.15.0" ]]; then
    echo -e "${RED}macOS version is less than 12.0 (Catalina). Exiting script.${NC}"
    exit 1
fi

#Prints logo
print_logo
echo "this is the $branch branch"
#Checks architecture
check_architecture

#sets zoom_url to zoom_arm64_url if cpu is arm otherwise it will keep intell link
 if [[ "$ARCH" == "arm64" ]]; then
     zoom_url="$zoom_arm64_url"
 fi
 #sets smart notebook url to smart_notebook22.1_url if os version is 11-10.15
 if [[ "$OS_VERSION" == 11.* || "$OS_VERSION" == 10.15.* ]]; then
     smart_notebook_url="$smart_notebook22_1_url"
 fi


install_applications(){
install_application_from_url "$app_cleaner_url"
install_application_from_url "$zoom_url"
install_application_from_url "$smart_notebook_url"
install_application_from_url "$google_chrome_url"
install_application_from_url "$air_server_url"
install_application_from_url "$crisis_go"
install_application_from_url "$cannon_driver_url"
}
#install_applications
#set_microsoft_word_version
install_application_from_url "Microsoft_Word_url"

print_finished

# Clean up
cd ..
rm -rf $TEMP_DIR


