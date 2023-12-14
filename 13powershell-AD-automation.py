# Creating a new user
New-ADUser -Name "Franz Ferdinand" -Title "TPS Reporting Lead" -Department "TPS Department" -Company "GlobeX USA" -Office "Springfield, OR" -EmailAddress "ferdi@GlobeXpower.com"

# Creating a new group in AD
New-ADGroup -Name "TPSReporters" -GroupScope Global -Path "OU=Groups,DC=YourDomain,DC=com" -Description "Group for TPS Reporting team"

# Creating a new OU in AD
New-ADOrganizationalUnit -Name "TPSDepartment" -Path "DC=YourDomain,DC=com" -Description "Organizational Unit for TPS Department"
