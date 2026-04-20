#!/bin/bash

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
BROWN='\033[0;33;2m' # Dim Yellow to approximate Brown
ORANGE='\033[0;31;1m' # Adjusted to be more orange
NC='\033[0m' # No Color

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
    sleep 0.5
}

start_smart_software(){
    echo -e "\033[33mStarting SMART Technologies software...\033[0m"

    echo -e "\033[33mStarting SMART Board Service...\033[0m"
    open "/Applications/SMART Technologies/SMARTBoardService.app"
    echo -e "\033[33mStarting SMART System Menu...\033[0m"
    open "/Applications/SMART Technologies/SMARTSystemMenu.app"
    echo -e "\033[33mStarting SMART Ink...\033[0m"
    open "/Applications/SMART Technologies/SMART Ink.app"
    echo -e "\033[33mStarting SMART Settings...\033[0m"
    open "/Applications/SMART Technologies/SMART Settings.app"
    sleep 0.5
}

cleanupSmartSoftware() {
    stop_smart_software
    echo "Cleaning up SMART Technologies software..."

    # Remove main application and library support files
    sudo rm -rf "/Applications/SMART Technologies"
    sudo rm -rf "/Library/Application Support/SMART Technologies"
    sudo rm -rf "/Library/Application Support/SMART Technologies Inc"
    sudo rm -rf "/Library/Shared/SMART Technologies"
    
    # Remove LaunchDaemons and LaunchAgents
    #sudo rm -f /Library/LaunchDaemons/com.smarttech.* #not sure if this is needed
    #sudo rm -f /Library/LaunchAgents/com.smarttech.*

    # Remove receipts
    sudo rm -f /var/db/receipts/com.smarttech.*

    # Remove caches and preferences
    sudo rm -rf /Library/Caches/com.smarttech.*
    for user_dir in /Users/*; do
        sudo rm -rf "$user_dir/Library/Application Support/SMART Technologies"
        sudo rm -rf "$user_dir/Library/Application Support/SMART Technologies Inc"
        sudo rm -rf "$user_dir/Library/Caches/com.smarttech.*"
        #sudo rm -f "$user_dir/Library/Preferences/com.smarttech.SMARTInk.plist"
        #sudo rm -f "$user_dir/Library/Preferences/com.smarttech.SMARTSystemMenu.plist"
        #sudo rm -f "$user_dir/Library/LaunchAgents/com.smarttech.*"
        sudo rm -rf "$user_dir/.smarttech"  # Hidden files
    done

    # Remove command-line binaries if any
    sudo rm -f /usr/local/bin/smart*
    sudo rm -f /usr/bin/smart*

    echo "SMART Technologies software cleanup completed."
}

fullcleanupSmartSoftware() {
    stop_smart_software
    echo "Cleaning up SMART Technologies software..."

    # Remove main application and library support files
    sudo rm -rf "/Applications/SMART Technologies"
    sudo rm -rf "/Library/Application Support/SMART Technologies"
    sudo rm -rf "/Library/Application Support/SMART Technologies Inc"
    sudo rm -rf "/Library/Shared/SMART Technologies"
    
    # Remove LaunchDaemons and LaunchAgents
    sudo rm -f /Library/LaunchDaemons/com.smarttech.*
    sudo rm -f /Library/LaunchAgents/com.smarttech.*

    # Remove receipts
    sudo rm -f /var/db/receipts/com.smarttech.*

    # Remove caches and preferences
    sudo rm -rf /Library/Caches/com.smarttech.*
    for user_dir in /Users/*; do
        sudo rm -rf "$user_dir/Library/Application Support/SMART Technologies"
        sudo rm -rf "$user_dir/Library/Application Support/SMART Technologies Inc"
        sudo rm -rf "$user_dir/Library/Caches/com.smarttech.*"
        sudo rm -f "$user_dir/Library/Preferences/com.smarttech.SMARTInk.plist"
        sudo rm -f "$user_dir/Library/Preferences/com.smarttech.SMARTSystemMenu.plist"
        sudo rm -f "$user_dir/Library/LaunchAgents/com.smarttech.*"
        sudo rm -rf "$user_dir/.smarttech"  # Hidden files
    done

    # Remove command-line binaries if any
    sudo rm -f /usr/local/bin/smart*
    sudo rm -f /usr/bin/smart*

    echo "SMART Technologies software full cleanup completed."
}

add_everyone_to_printer_group(){
    #add everyone to lpadmin group to allow everyone to add a printer
    echo -e "${GREEN}Adding everyone to lpadmin group to allow everyone to add a printer...${NC}"
    sudo /usr/sbin/dseditgroup -o edit -n /Local/Default -a everyone -t group lpadmin
    sleep 0.5
}

install_applications_teacher(){
    add_everyone_to_printer_group
    install_application_from_url "$app_cleaner_url"
    install_application_from_url "$zoom_url"
    fullcleanupSmartSoftware
    install_application_from_url "$smart_notebook_url"
    start_smart_software
    install_application_from_url "$google_chrome_url"
    install_application_from_url "$google_drive_url"
    #install_application_from_url "$air_server_url"
    install_application_from_url "$crisis_go"
    install_application_from_url "$cannon_driver"
    install_application_from_url "$visualizer_url"  
    install_application_from_url "$onyx_url"
}

install_applications_office(){
    install_application_from_url "$app_cleaner_url"
    install_application_from_url "$zoom_url"
    install_application_from_url "$google_chrome_url"
    install_application_from_url "$google_drive_url"
    install_application_from_url "$crisis_go"
    install_application_from_url "$cannon_driver"
    install_application_from_url "$onyx_url"

}

install_applications_everything(){
    add_everyone_to_printer_group
    #slow 
    install_application_from_url "$word_url"
    install_application_from_url "$excel_url"
    install_application_from_url "$powerpoint_url"
    #Normal 
    install_application_from_url "$app_cleaner_url"
    install_application_from_url "$zoom_url"
    fullcleanupSmartSoftware
    install_application_from_url "$smart_notebook_url"
    start_smart_software
    install_application_from_url "$google_chrome_url"
    install_application_from_url "$air_server_url"
    install_application_from_url "$crisis_go"
    install_application_from_url "$cannon_driver"
    install_application_from_url "$visualizer_url"  
    install_application_from_url "$onyx_url"

}

install_applications_music_teacher(){
    add_everyone_to_printer_group
    install_application_from_url "$VCast_url"
    install_application_from_url "$GarageBand"
    install_application_from_url "$app_cleaner_url"
    install_application_from_url "$zoom_url"
    fullcleanupSmartSoftware
    install_application_from_url "$smart_notebook_url"
    start_smart_software
    install_application_from_url "$google_chrome_url"
    install_application_from_url "$google_drive_url"
    install_application_from_url "$air_server_url"
    install_application_from_url "$crisis_go"
    install_application_from_url "$cannon_driver"
    install_application_from_url "$visualizer_url"  
    install_application_from_url "$onyx_url"
}
list_and_install_applications() {
    echo -e "${NC}Please select the applications you would like to install by entering the corresponding numbers separated by spaces and pressing enter:${NC}"
    echo -e "${NC}(Type 'back' to go back to the main menu)${NC}"
    
    options=(
        "${BROWN}App Cleaner${NC}"
        "${BLUE}Zoom${NC}"
        "${CYAN}Smart Notebook${NC}"
        "${YELLOW}Google Chrome${NC}"
        "${MAGENTA}Google Drive${NC}"
        "${NC}Air Server${NC}"
        "${RED}Crisis Go${NC}"
        "${NC}Canon Driver${NC}"
        "${BLUE}Visualizer${NC}"
        "${MAGENTA}OnyX${NC}"
        "${BLUE}Microsoft Word${NC}"
        "${GREEN}Microsoft Excel${NC}"
        "${ORANGE}Microsoft PowerPoint${NC}"
        "${RED}GarageBand${NC}"
        "${MAGENTA}VCast${NC}"
    )

    for i in "${!options[@]}"; do
        echo -e "$((i+1)). ${options[i]}"
    done

    read -p "Enter your choices: " -a choices

    # Check if user wants to go back
    if [ "${choices[0]}" = "back" ]; then
        first_choice
        return
    fi

    # Add everyone to printer group after selection but before installation
    add_everyone_to_printer_group

    for choice in "${choices[@]}"; do
        case $choice in
            1) install_application_from_url "$app_cleaner_url" ;;
            2) install_application_from_url "$zoom_url" ;;
            3) 
                # If Smart Notebook is selected, remove the SMART Technologies folder
                fullcleanupSmartSoftware
                install_application_from_url "$smart_notebook_url"
                start_smart_software
                ;;
            4) install_application_from_url "$google_chrome_url" ;;
            5) install_application_from_url "$google_drive_url" ;;
            6) install_application_from_url "$air_server_url" ;;
            7) install_application_from_url "$crisis_go" ;;
            8) install_application_from_url "$cannon_driver" ;;
            9) install_application_from_url "$visualizer_url" ;;
            10) install_application_from_url "$onyx_url" ;;
            11) install_application_from_url "$word_url" ;;
            12) install_application_from_url "$excel_url" ;;
            13) install_application_from_url "$powerpoint_url" ;;
            14) install_application_from_url "$GarageBand" ;;
            15) install_application_from_url "$VCast_url" ;;
            *) echo "Invalid choice: $choice" ;;
        esac
    done
}

# first_choice(){
#     read -p "Will This computer be used with a Smart Board? (y/n) or would you like to manually select applications? (m)" answer
#     if [[ "$answer" == "y" ]]; then
#         #remove smart technologies folder from /Applications to prevent errors
#         fullcleanupSmartSoftware
#         install_applications_teacher
#     elif [[ "$answer" == "n" ]]; then
#         install_applications_office
#     elif [[ "$answer" == "m" ]]; then
#         list_and_install_applications
#     else
#         echo "Invalid choice: $answer"
#     fi
# }

first_choice(){
    echo "Please select an option by entering the corresponding number and pressing enter:"
    echo -e "${YELLOW}1. Update using Teacher preset${NC}"
    echo -e "${CYAN}2. Update using Office Macmini preset${NC}"
    echo -e "${GREEN}3. Update everything - This will take a while${NC}" 
    echo -e "${MAGENTA}4. Manually select what to update${NC}"
    echo -e "${BLUE}5. Update using Music Teacher preset${NC}"
    echo -e "${RED}6. More Options${NC}"
    echo -e "${BLUE}7. Exit${NC}"
    
    read -p "Enter your choice (1-7): " choice
    
    case $choice in
        1)
            clear
            install_applications_teacher
            ;;
        2)
            clear
            install_applications_office
            ;;
        3)
            clear
            install_applications_everything
            ;;
        4)
            clear
            list_and_install_applications
            ;;
        5)
            clear
            install_applications_music_teacher
            ;;
        6)
            clear
            more_options
            ;;
        7)
            echo "Exiting..."
            exit 0
            ;;
        *)
            clear
            echo "Invalid choice: $choice"
            first_choice
            ;;
    esac
}

more_options(){
    echo "Please select an option by entering the corresponding number and pressing enter:"
    echo -e "${YELLOW}1. Add everyone to the printer group${NC}"
    echo -e "${CYAN}2. Purge SMART software${NC}"
    echo -e "${GREEN}3. Stop SMART software${NC}" 
    echo -e "${BLUE}4. Start SMART software${NC}"
    echo -e "${MAGENTA}5. Main Menu${NC}"
    echo -e "${RED}6. Exit${NC}"
    
    read -p "Enter your choice (1-6): " choice
    
    case $choice in
        1)
            clear
            add_everyone_to_printer_group
            more_options
            ;;
        2)
            clear
            fullcleanupSmartSoftware
            more_options
            ;;
        3)
            clear
            stop_smart_software
            
            more_options
            ;;
        4)
            clear
            start_smart_software
            more_options
            ;;
        5)
            clear
            first_choice
            ;;
        6)
            clear
            echo "Exiting..."
            exit 0
            ;;
    esac
}