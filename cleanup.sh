#!/bin/bash

ask_cleanup() {
    read -p "Would you like to clean up script files? (yes/no): " response
    case "$response" in
        [Yy][Ee][Ss]|[Yy])
            echo "Cleaning up script files..."
            # Add the cleanup commands here
            ;;
        [Nn][Oo]|[Nn])
            echo "Skipping cleanup."
            ;;
        *)
            echo "Invalid response. Please answer yes or no."
            ask_cleanup
            ;;
    esac
}

# Call the function
#ask_cleanup

cleanup() {
    temp_dir=$1
    starting_dir=$2
    # Clean up the temp directory
    cd ..
    rm -rf $temp_dir
    echo -e "${GREEN}Cleaned up the temp directory${NC}"

    # Clean up the update.sh file
    cd $starting_dir
    rm update.sh
    echo -e "${GREEN}Cleaned up the update.sh file${NC}"
}

fullcleanupSmartSoftware() {
    echo -e "\033[33mCleaning up SMART Technologies software...\033[0m"

    # Function to check and remove files/directories
    remove_if_exists() {
        if [ -e "$1" ]; then
            echo "Removing $1"
            sudo rm -rf "$1"
        fi
    }

    # Remove main application and library support files
    remove_if_exists "/Applications/SMART Technologies"
    remove_if_exists "/Library/Application Support/SMART Technologies"
    remove_if_exists "/Library/Application Support/SMART Technologies Inc"
    remove_if_exists "/Library/Shared/SMART Technologies"
    
    # Remove LaunchDaemons and LaunchAgents
    remove_if_exists "/Library/LaunchDaemons/com.smarttech.*"
    remove_if_exists "/Library/LaunchAgents/com.smarttech.*"

    # Remove receipts
    remove_if_exists "/var/db/receipts/com.smarttech.*"

    # Remove caches and preferences
    remove_if_exists "/Library/Caches/com.smarttech.*"
    for user_dir in /Users/*; do
        remove_if_exists "$user_dir/Library/Application Support/SMART Technologies"
        remove_if_exists "$user_dir/Library/Application Support/SMART Technologies Inc"
        remove_if_exists "$user_dir/Library/Caches/com.smarttech.*"
        remove_if_exists "$user_dir/Library/Preferences/com.smarttech.SMARTInk.plist"
        remove_if_exists "$user_dir/Library/Preferences/com.smarttech.SMARTSystemMenu.plist"
        remove_if_exists "$user_dir/Library/LaunchAgents/com.smarttech.*"
        remove_if_exists "$user_dir/.smarttech"  # Hidden files
    done

    # Remove command-line binaries if any
    remove_if_exists "/usr/local/bin/smart*"
    remove_if_exists "/usr/bin/smart*"

    echo -e "\033[32mSMART Technologies software full cleanup completed.\033[0m"
}

stop_smart_software() {
    echo -e "\033[33mStopping SMART Technologies software...\033[0m"
    
    # Kill all SMART Technologies related processes by executable name
    sudo pkill -f "/Applications/SMART Technologies/SMART Settings.app/Contents/bin/sbsdk-server/SBWDKService" || true
    sudo pkill -f "/Applications/SMART Technologies/SMART Ink.app/Contents/MacOS/SMART Ink" || true
    sudo pkill -f "/Applications/SMART Technologies/SMART Settings.app/Contents/bin/SystemNotifications.app/Contents/MacOS/SystemNotifications" || true
    sudo pkill -f "/Applications/SMART Technologies/SMARTBoardService.app/Contents/MacOS/SMARTBoardService" || true
    sudo pkill -f "/Applications/SMART Technologies/SMARTSystemMenu.app/Contents/MacOS/SMARTSystemMenu" || true
    sudo pkill -f "crashpad_handler2" || true

    # Unload any launch daemons or agents
    if [ -e "/Library/LaunchDaemons/com.smarttech.*" ]; then
        sudo launchctl unload /Library/LaunchDaemons/com.smarttech.*
    fi
    if [ -e "/Library/LaunchAgents/com.smarttech.*" ]; then
        sudo launchctl unload /Library/LaunchAgents/com.smarttech.*
    fi

    echo -e "\033[32mSMART Technologies software services stopped.\033[0m"
}

fullcleanupSmartSoftware
stop_smart_software
#cleanup
rm cleanup.sh



