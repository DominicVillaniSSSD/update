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

#sets office version
set_microsoft_office_version
#sets onyx version and url
set_onyx_version
#sets zoom version
set_zoom_version
#sets smart notebook version
set_smart_notebook_version

install_applications(){
    install_application_from_url "$app_cleaner_url" > app_cleaner.log 2>&1 && echo -e "${GREEN}App Cleaner installed successfully.${NC}" || echo -e "${RED}Failed to install App Cleaner.${NC}" &
    install_application_from_url "$zoom_url" > zoom.log 2>&1 && echo -e "${GREEN}Zoom installed successfully.${NC}" || echo -e "${RED}Failed to install Zoom.${NC}" &
    install_application_from_url "$smart_notebook_url" > smart_notebook.log 2>&1 && echo -e "${GREEN}Smart Notebook installed successfully.${NC}" || echo -e "${RED}Failed to install Smart Notebook.${NC}" &
    install_application_from_url "$Microsoft_Word_url" > word.log 2>&1 && echo -e "${GREEN}Microsoft Word installed successfully.${NC}" || echo -e "${RED}Failed to install Microsoft Word.${NC}" &
    install_application_from_url "$Microsoft_Excel_url" > excel.log 2>&1 && echo -e "${GREEN}Microsoft Excel installed successfully.${NC}" || echo -e "${RED}Failed to install Microsoft Excel.${NC}" &
    install_application_from_url "$Microsoft_PowerPoint_url" > powerpoint.log 2>&1 && echo -e "${GREEN}Microsoft PowerPoint installed successfully.${NC}" || echo -e "${RED}Failed to install Microsoft PowerPoint.${NC}" &
    install_application_from_url "$air_server_url" > air_server.log 2>&1 && echo -e "${GREEN}Air Server installed successfully.${NC}" || echo -e "${RED}Failed to install Air Server.${NC}" &
    install_application_from_url "$crisis_go" > crisis_go.log 2>&1 && echo -e "${GREEN}Crisis Go installed successfully.${NC}" || echo -e "${RED}Failed to install Crisis Go.${NC}" &
    install_application_from_url "$onyx_url" > onyx.log 2>&1 && echo -e "${GREEN}Onyx installed successfully.${NC}" || echo -e "${RED}Failed to install Onyx.${NC}" &
    install_application_from_url "$cannon_driver_url" > cannon_driver.log 2>&1 && echo -e "${GREEN}Cannon Driver installed successfully.${NC}" || echo -e "${RED}Failed to install Cannon Driver.${NC}" &
    install_application_from_url "$google_chrome_url" > google_chrome.log 2>&1 && echo -e "${GREEN}Google Chrome installed successfully.${NC}" || echo -e "${RED}Failed to install Google Chrome.${NC}" &
    
    # Wait for all installations to complete
    wait
}

#install_applications

#dubugging
echo "Microsoft Word URL: $Microsoft_Word_url"
echo "Microsoft Excel URL: $Microsoft_Excel_url"
echo "Microsoft PowerPoint URL: $Microsoft_PowerPoint_url"
echo "Zoom URL: $zoom_url"
echo "Smart Notebook URL: $smart_notebook_url"
echo "Onyx URL: $onyx_url"

print_finished

# Clean up
cd ..
rm -rf $TEMP_DIR



