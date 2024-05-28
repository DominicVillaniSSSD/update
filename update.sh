#!/bin/bash

source setup.sh
source install_handlers.sh
source curl.sh
source logo.sh

#Prints logo
print_logo

#Checks architecture
check_architecture

install_applications(){
install_application_from_url "$zoom_url"
install_application_from_url "$smart_notebook_url"
install_application_from_url "$google_chrome_url"
install_application_from_url "$app_cleaner_url"
install_application_from_url "$air_server_url"
}

install_applications

