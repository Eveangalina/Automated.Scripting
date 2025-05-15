# Ensure the AD module is available
Import-Module ActiveDirectory

# Set the OU path where users will be created
$ouPath = "OU=MSSA01,DC=sandbox,DC=local"

# Define user list
$users = @(
    @{FirstName="Cat"; LastName="Lopez"; Username="clopez"},
    @{FirstName="Lola"; LastName="Lo"; Username="llo"},
    @{FirstName="Sue"; LastName="Runner"; Username="srunner"}
)

# Loop through each user and create them
foreach ($user in $users) {
    $name = "$($user.FirstName) $($user.LastName)"
    $samAccountName = $user.Username
    $password = ConvertTo-SecureString "P@ssword123!" -AsPlainText -Force

    New-ADUser `
        -Name $name `
        -GivenName $user.FirstName `
        -Surname $user.LastName `
        -SamAccountName $samAccountName `
        -UserPrincipalName "$samAccountName@sandbox.local" `
        -AccountPassword $password `
        -Path $ouPath `
        -Enabled $true `
        -ChangePasswordAtLogon $true `
        -Description "Created by automation script"
        
    Write-Host "User $name created successfully." -ForegroundColor Green
}
