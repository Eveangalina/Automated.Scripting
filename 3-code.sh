#!/bin/bash

# Script Name:              File Permissions
#: Author:                  Eve
#: Date of latest revision  11/29/23
#: Resources:               https://chat.openai.com/share/2bf3a6a0-cd07-4c45-b959-c8c34bf0ce8f 

#: Decloration of Function
change-Permissions () {
    read -p "Enter the directory path: " directory
    read -p "Enter the input permissions number: " permission_number

    cd "$directory"
    chmod $permission_number *
    ls -l 
}
change-Permissions

# Resources:        Help from classmates Juan Cano and Marcus Nogueria