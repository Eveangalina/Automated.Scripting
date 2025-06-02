##############################################
# Mac Setup Script for Azure Bot Project
# Author: Eveangalina Campos
# Purpose: Prepares a Mac to deploy and manage 
# Azure resources using CLI and Bicep templates
# Date: June 1, 2025
##############################################

# 1. Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. Add Homebrew to your PATH
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# 3. Verify Homebrew is working
brew --version

# 4. Install Azure CLI
brew install azure-cli

# 5. Install Bicep CLI
az bicep install

# 6. Navigate to your Downloads folder (where template.json is located)
cd ~/Downloads

# 7. Convert the ARM template to Bicep format
az bicep decompile --file template.json
