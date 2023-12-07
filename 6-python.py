# Python

# Script Name:                  Ops Challenge: Bash in Python
# Author:                       Eveangalina Campos
# Date of latest revision:      12/06/2023
# Purpose:                      Ensures consistency and adherence to the Python naming conventions. 
# Execution:                    6-python.py
# Resource:                     https://chat.openai.com/share/ce02362c-b0ed-4958-b719-def45cb5e2db


# Import the 'os' module
import os

# Declare and initialize variables
variable1 = "eve"
variable2 = 27
variable3 = True

# Print the variables
print("variable 1:", variable1)
print("variable 2:", variable2)
print("variable 3:", variable3)

# Execute bash commands using the 'os' module
# Command 1: whoami
whoami_result = os.popen("whoami").read()
print("UserLogIn: \n", whoami_result)

ip_result = os.popen("ip a").read()
print("IP addresses: \n", ip_result)

# Command 3: lshw -short
lshw_result = os.popen("sudo lshw -short").read()
print("Hardware information:\n", lshw_result)
