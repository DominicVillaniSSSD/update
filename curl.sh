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

set_microsoft_office_version() {
    if [[ "$OS_VERSION" =~ ^10\.15\..* ]]; then
        version="16.66.22101101"
        sha256="5a6a75d9a5b46cceeff5a1b7925c0eab6e4976cba529149b7b291a0355e7a7c9"
        livecheck_skip="Legacy version"
    elif [[ "$OS_VERSION" =~ ^11\..* ]]; then
        version="16.77.23091703"
        sha256="10c8db978206275a557faf3650763a656b1f7170c9b2a65fa6fdce220bd23066"
        livecheck_skip="Legacy version"
    elif [[ "$OS_VERSION" =~ ^12\..* || "$OS_VERSION" > "12.*" ]]; then
        version="16.86.24060916"
        sha256="e84da3bf72fad24b551d5d6589ee2edb440cf9ea7d173ad38ad00314f85fc0d7"
        livecheck_url="https://go.microsoft.com/fwlink/p/?linkid=525134"
        livecheck_strategy="header_match"
    fi

    Microsoft_Word_url="https://officecdnmac.microsoft.com/pr/C1297A47-86C4-4C1F-97FA-950631F94777/MacAutoupdate/Microsoft_Word_${version}_Installer.pkg"
    Microsoft_Excel_url="https://officecdnmac.microsoft.com/pr/C1297A47-86C4-4C1F-97FA-950631F94777/MacAutoupdate/Microsoft_Excel_${version}_Installer.pkg"
    Microsoft_PowerPoint_url="https://officecdnmac.microsoft.com/pr/C1297A47-86C4-4C1F-97FA-950631F94777/MacAutoupdate/Microsoft_PowerPoint_${version}_Installer.pkg"
}

set_onyx_version() {
    echo "OS_VERSION: $OS_VERSION"  # Debug statement to print OS_VERSION
    if [[ "$OS_VERSION" =~ ^10\.15\..* ]]; then
        version="3.8.7"
        onyx_url="https://www.titanium-software.fr/download/1015/OnyX.dmg"
    elif [[ "$OS_VERSION" =~ ^11\..* ]]; then
        version="4.0.2"
        onyx_url="https://www.titanium-software.fr/download/11/OnyX.dmg"
    elif [[ "$OS_VERSION" =~ ^12\..* ]]; then
        version="4.2.7"
        onyx_url="https://www.titanium-software.fr/download/12/OnyX.dmg"
    elif [[ "$OS_VERSION" =~ ^13\..* ]]; then
        version="4.4.7"
        onyx_url="https://www.titanium-software.fr/download/13/OnyX.dmg"
    elif [[ "$OS_VERSION" =~ ^14\..* || "$OS_VERSION" > "14.*" ]]; then
        version="4.5.9"
        onyx_url="https://www.titanium-software.fr/download/14/OnyX.dmg"
    fi

    echo "OnyX URL: $onyx_url"  # Debug statement to print the selected URL
}

set_zoom_version() {
    #sets zoom_url to zoom_arm64_url if cpu is arm otherwise it will keep intell link
 if [[ "$ARCH" == "arm64" ]]; then
     zoom_url="$zoom_arm64_url"
 fi
}

set_smart_notebook_version() {
#sets smart notebook url to smart_notebook22.1_url if os version is 11-10.15
 if [[ "$OS_VERSION" == 11.* || "$OS_VERSION" == 10.15.* ]]; then
     smart_notebook_url="$smart_notebook22_1_url"
 fi
}

install_application_from_url() {
    local app_url=$1
    local file_name=$(basename "${app_url%%\?*}")  # Strip query parameters from the URL
    echo "$file_name"

    echo -e "${YELLOW}Downloading application from URL: $app_url...${NC}"
    curl -L -O "$app_url"  # Use -O option to save with the remote name

    if [[ -f "$file_name" ]]; then  # Check if the file with remote name exists
        echo -e "${GREEN}Download successful. Installing application...${NC}"
        process_file "$file_name"
        if [[ "$file_name" == *.zip ]]; then
            rm -r "/tmp/$(basename "$file_name" .zip)"  # Remove unzipped directory
        fi
        rm "$file_name"  # Remove the original downloaded file
    else
        echo -e "${RED}Failed to download the application.${NC}"
    fi
}
