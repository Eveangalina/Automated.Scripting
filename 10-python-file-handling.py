#!/usr/bin/env python3
# Script:                       Ops Challenge: Python File Handling
# Author:                       Eveangalina Campos
# Date of latest revision:      12/08/23
# Purpose:                      File Handling in Python

import os

# Variable Declarations
file_path = "my_file.txt"

# Main
def create_and_manipulate_file():
    # Create a new .txt file and append three lines
    with open(file_path, "w") as file:
        file.write("First line\n")
        file.write("Second line\n")
        file.write("Third line\n")

    # Open the file to read the first line and print it
    with open(file_path, "r") as file:
        first_line = file.readline()
        print("First line:", first_line.strip())

    # Delete the .txt file
    os.remove(file_path)
    print(f"File '{file_path}' deleted.")

# Execute the main function
if __name__ == "__main__":
    create_and_manipulate_file()
# resources  [ChatGPT] (https://chat.openai.com/share/52d44b2d-fa4a-4911-8644-4cbe29dc024e)