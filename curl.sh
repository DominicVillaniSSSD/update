#!/bin/bash
source setup.sh
source install_handlers.sh

google_chrome_url="https://dl.google.com/chrome/mac/universal/stable/GGRO/googlechrome.dmg"
google_drive_url="https://dl.google.com/drive-file-stream/GoogleDrive.dmg"
smart_notebook_url="https://downloads.smarttech.com/software/education/23.2/mac/23.2.278.0/smart23-2-web.dmg"
zoom_url="https://zoom.us/client/latest/Zoom.pkg"
air_server_url="https://dl.airserver.com/mac/AirServer-7.2.7.dmg"
app_cleaner_url="https://freemacsoft.net/downloads/AppCleaner_3.6.8.zip"

zoom_intell_url="https://zoom.us/client/latest/Zoom.pkg"
zoom_apple_silicon_url="https://zoom.us/client/latest/Zoom.pkg?archType=arm64"
crisis_go_url="https://crisisgoapp.s3.amazonaws.com/Mac/CrisisGo_6.22.1.pkg"

Install_application_from_url() {
    local app_url=$1
    local temp_file="/tmp/$(basename "$app_url")"

    echo -e "${YELLOW}Downloading application from URL: $app_url...${NC}"
    curl -L -o "$temp_file" -J "$app_url"

    # Extract filename from the headers if available
    local content_disposition=$(curl -I -s "$app_url" | grep -i 'content-disposition:')
    if [[ $content_disposition =~ filename=\"(.+)\" ]]; then
        local file_name=${BASH_REMATCH[1]}
        mv "$temp_file" "/tmp/$file_name"
        temp_file="/tmp/$file_name"
    fi

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



