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
curl -L -o curl.sh https://raw.githubusercontent.com/DominicVillaniSSSD/update/$branch/curl.sh > curl.log 2>&1 &
curl -L -o install_handlers.sh https://raw.githubusercontent.com/DominicVillaniSSSD/update/$branch/install_handlers.sh > install_handlers.log 2>&1 &
curl -L -o logo.sh https://raw.githubusercontent.com/DominicVillaniSSSD/update/$branch/logo.sh > logo.log 2>&1 &
curl -L -o setup.sh https://raw.githubusercontent.com/DominicVillaniSSSD/update/$branch/setup.sh > setup.log 2>&1 &

# Wait for all downloads to complete
wait

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

#sets office version
set_microsoft_office_version

#sets onyx version and url
set_onyx_version_and_url

install_applications(){
    install_application_from_url "$app_cleaner_url" > app_cleaner.log 2>&1 && echo "App Cleaner installed successfully." || echo "Failed to install App Cleaner." &
    install_application_from_url "$zoom_url" > zoom.log 2>&1 && echo "Zoom installed successfully." || echo "Failed to install Zoom." &
    install_application_from_url "$smart_notebook_url" > smart_notebook.log 2>&1 && echo "Smart Notebook installed successfully." || echo "Failed to install Smart Notebook." &
    install_application_from_url "$Microsoft_Word_url" > word.log 2>&1 && echo "Microsoft Word installed successfully." || echo "Failed to install Microsoft Word." &
    install_application_from_url "$Microsoft_Excel_url" > excel.log 2>&1 && echo "Microsoft Excel installed successfully." || echo "Failed to install Microsoft Excel." &
    install_application_from_url "$Microsoft_PowerPoint_url" > powerpoint.log 2>&1 && echo "Microsoft PowerPoint installed successfully." || echo "Failed to install Microsoft PowerPoint." &
    install_application_from_url "$air_server_url" > air_server.log 2>&1 && echo "Air Server installed successfully." || echo "Failed to install Air Server." &
    install_application_from_url "$crisis_go" > crisis_go.log 2>&1 && echo "Crisis Go installed successfully." || echo "Failed to install Crisis Go." &
    install_application_from_url "$onyx_url" > onyx.log 2>&1 && echo "Onyx installed successfully." || echo "Failed to install Onyx." &
    install_application_from_url "$cannon_driver_url" > cannon_driver.log 2>&1 && echo "Cannon Driver installed successfully." || echo "Failed to install Cannon Driver." &
    install_application_from_url "$google_chrome_url" > google_chrome.log 2>&1 && echo "Google Chrome installed successfully." || echo "Failed to install Google Chrome." &
    
    # Wait for all installations to complete
    wait
}

install_applications

print_finished

# Clean up
cd ..
rm -rf $TEMP_DIR



