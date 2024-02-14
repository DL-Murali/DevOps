# Linux Task: 

-> Set up a collaborative file management system on an Ubuntu server by creating a shared directory, creating users and groups, and assigning appropriate permissions and ownership for effective collaboration.

# Steps:
1. Enable Password Authentication in Server
2. Add 2 users and set Password for them
3. Create one Group and assign users to it
4. Create 1 Shared Directory with 2 Sub-Directories
5. Set permissions and ownership of Shared Directory
6. change ownership of that created sub-directories with respect to users
7. Now login the servers with Username and Password
8. Now try to add the content to respected directories --- It should be Successful
9. Now Try to add the content to other user directory ---- It should be throw error ( Permission Denaid )


# SOLUTION

## Update system
-> sudo apt update

## Enable Password Authentication
-> sudo nano /etc/ssh/sshd_config
   -> PasswordAuthentication yes

## Restart the SSH service to apply the changes
-> sudo systemctl restart sshd


## Add User and Set Password
-> sudo adduser murali
  -> New Password: murali123
  -> Full Name: murali krishna

## Add User and Set Password
-> sudo adduser krishna
  -> New Password: krishna123
  -> Full Name: krishna alakuntla

## check users in the server
-> getent passwd  ------> getent passwd | grep <username>
-> cat /etc/passwd -----> cat /etc/passwd | grep <username>
  
## Check Login
-> Open Gitbash terminal
-> ssh username@pub-ip
-> ssh murali@54.183.140.90
  -> Enter Password: enter-password
  -> Enter Password: murali123

## Check Login
-> Open Gitbash terminal
-> ssh username@pub-ip
-> ssh krishna@54.183.140.90
  -> Enter Password: enter-password
  -> Enter Password: krishna123

## Create a Group for Collaboration

-> sudo addgroup lms-team
-> checking group: 
  -> getent group | grep lms-team
  -> cat /etc/group | grep lms-team

## Assign Users to the Group
-> sudo usermod -aG lms-team murali
-> sudo usermod -aG lms-team krishna
-> checking group:
  -> getent group lms-team
  -> cat /etc/group | grep lms-team

## Create Directory with Sub-Directories

-> sudo mkdir lms-project
-> cd lms-project/
-> mkdir lms-murali
-> mkdir lms-krishna

## Set Permissions and Ownership for the Shared Directory

-> sudo chmod 770 ~/lms-project
-> ls -l  ----> to check permissions
-> sudo chown :lms-team ~/lms-project

## Ensure Proper Permissions for New Files
-> sudo chmod g+s ~/lms-project

## change ownership of that created directories with respect to users

-> switch to root user
  -> sudo su

-> user-murali: 
  -> sudo chown murali:lms-team lms-murali
  -> sudo chmod 740 lms-murali

-> user-krishna: 
  -> sudo chown krishna:lms-team lms-krishna
  -> sudo chmod 740 lms-krishna

## Testing the Permissions and Working on Shared Directory

-> Login to server with username and password
-> Add some file/content to respected directory -----> It will add successfully
-> Try to add some file/content to Others Directory -----> It should throw an Error (Permission Denaid)

























