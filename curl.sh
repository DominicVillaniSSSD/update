#!/bin/bash
source setup.sh
source install_handlers.sh

#Latest Release
google_chrome_url="https://dl.google.com/chrome/mac/universal/stable/GGRO/googlechrome.dmg"
google_drive_url="https://dl.google.com/drive-file-stream/GoogleDrive.dmg"
crisis_go="https://crisisgoapp.s3.amazonaws.com/Mac/CrisisGo_latest.pkg"
zoom_url="https://zoom.us/client/latest/Zoom.pkg"
# arm zoom link
zoom_arm64_url="https://zoom.us/client/latest/Zoom.pkg?archType=arm64" 

#Version specific 
smart_notebook_url="https://downloads.smarttech.com/software/education/24.0/mac/24.0.240.1/smart24-0-web.dmg"
smart_notebook22_1_url="https://downloads.smarttech.com/software/education/22.1/mac/22.1.496.0/smart22-1-web.dmg"
air_server_url="https://dl.airserver.com/mac/AirServer-7.2.7.dmg"
app_cleaner_url="https://freemacsoft.net/downloads/AppCleaner_3.6.8.zip"
cannon_driver_url="https://downloads.canon.com/bicg2024/drivers/PS-v4.17.17-Mac.zip"

Microsoft_Word_url="https://officecdnmac.microsoft.com/pr/C1297A47-86C4-4C1F-97FA-950631F94777/MacAutoupdate/Microsoft_Word_16.86.24060916_Installer.pkg"

#Microsoft_Word_url=https://officecdnmac.microsoft.com/pr/C1297A47-86C4-4C1F-97FA-950631F94777/MacAutoupdate/Microsoft_Word_$version_Installer.pkg

# set_microsoft_word_version() {
#     if [[ "$OS_VERSION" == "10.15.*" ]]; then
#         version="16.66.22101101"
#         sha256="5a6a75d9a5b46cceeff5a1b7925c0eab6e4976cba529149b7b291a0355e7a7c9"
#         livecheck_skip="Legacy version"
#     elif [[ "$OS_VERSION" == "11.*" ]]; then
#         version="16.77.23091703"
#         sha256="10c8db978206275a557faf3650763a656b1f7170c9b2a65fa6fdce220bd23066"
#         livecheck_skip="Legacy version"
#     elif [[ "$OS_VERSION" == "12.*" || "$OS_VERSION" > "12.*" ]]; then
#         version="16.86.24060916"
#         sha256="e84da3bf72fad24b551d5d6589ee2edb440cf9ea7d173ad38ad00314f85fc0d7"
#         livecheck_url="https://go.microsoft.com/fwlink/p/?linkid=525134"
#         livecheck_strategy="header_match"
#     fi
# }


install_application_from_url() {
    local app_url=$1
    local file_name=$(basename "${app_url%%\?*}")  # Strip query parameters from the URL
    local temp_file="/tmp/$file_name"

    echo -e "${YELLOW}Downloading application from URL: $app_url...${NC}"
    curl -L -o "$temp_file" "$app_url"

    if [[ -f "$temp_file" ]]; then
        echo -e "${GREEN}Download successful. Installing application...${NC}"
        process_file "$temp_file"
        if [[ "$temp_file" == *.zip ]]; then
            rm -r "/tmp/$(basename "$temp_file" .zip)"  # Remove unzipped directory
        fi
        rm "$temp_file"  # Remove the original downloaded file
    else
        echo -e "${RED}Failed to download the application.${NC}"
    fi
}
