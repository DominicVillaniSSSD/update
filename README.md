# Update tool for Mac Applications at the Sulphur Springs School District 
This Tool will not update the OS version just a handfull of apps that are listed bellow 

## How to run:

### Option 1  
Paste this one liner command below into the terminal with a user account with admin privileges  
```
curl -O https://raw.githubusercontent.com/DominicVillaniSSSD/SSSDUpdate/refs/heads/main/update.sh && chmod +x update.sh && sudo ./update.sh
```

### Option 2
Clone repo and sudo run update.sh 
```
git clone https://github.com/DominicVillaniSSSD/SSSDUpdate
 cd SSSDUpdate
 chmod +x update.sh
 ./update.sh 
```

### **This will update these apps:**  
Zoom (latest release)  
Chrome (latest release for each macOS version)  
Google Drive (latest release)  
crisis go (latest release)  
Onyx (latest release for each macOS version) 
MS Office (latest release for each macOS version)  
###### **Version Spesific** 
Air server 7.2.7  
app_Cleaner 3.6.8  
Visualizer 3.6.8  
cannon_driver PS-v4.17.17  
smart_notebook 22.0.240.1 (For newer MacOS versions) or  
smart_notebook 21.1 (For older MacOS Versions [Big Sur, Catalina])     


## *Note this script is only validated to work in MacOS Catalina and up. Some of the Software included in this script is version specific and may need to be changed to work with older version of MacOS. 
