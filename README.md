# Update tool for Mac Applications at the Sulpher Springs School District 
This Tool will not update the OS version just a handfull of apps that are listed bellow 

## How to run:
To run this script paste the command below into the terminal with a user account with admin privileges  
### How to run with a non privileged user:
Run su and the username of an admin user ex: su admin  
Then enter in the password in for the user you have just typed in
you will also need to type exit in the terminal once the script is complete 


```
curl -O https://raw.githubusercontent.com/DominicVillaniSSSD/update/test/update.sh && chmod +x update.sh && sudo ./update.sh
```

### **This will update these apps:**  
Zoom (latest release)  
Chrome (latest release)  
Google Drive (latest release)  
crisis go (latest release)  
#### **Version Spesific** 
Air server 7.2.7  
app_Cleaner 3.6.8  
cannon_driver PS-v4.17.17  
smart_notebook 24.0.240.1 (For newer MacOS versions) or
smart_notebook 21.1m (For older MacOS Versions [Big Sur, Catolina])


## * Note this script is only validated to work in MacOS Catalonia and up. Some of the Software included in this script is version specific and may need to be changed to work with older version of MacOS



