# Import the Active Directory module.
Import-Module ActiveDirectory

# Define the number of days to consider a user as inactive.
$DaysInactive = 90

# Calculate the date X days ago (where X is the value of $DaysInactive) from the current date.
$time = (Get-Date).Adddays(-($DaysInactive))

# Define the list of OUs to search for inactive users. 
# Substitute for OU's in your environment
$OUs = "OU=Finance,OU=Users,DC=contoso,DC=com", 
        "OU=Finance,OU=Users,DC=contoso,DC=com", 
        "OU=NY,OU=Users,DC=contoso,DC=com",
        "OU=LA,OU=Users,DC=contoso,DC=com" 
        
# Initialize an empty array to store the inactive users.
$InactiveUsers = @()

# Loop over each OU.
foreach($OU in $OUs){
    # Retrieve all AD users within the OU that are enabled and have not logged in since the specified date.
    $Users = Get-ADUser -SearchBase $OU -Properties LastLogonDate,EmailAddress,Manager -Filter {Enabled -eq $True -and LastLogonDate -le $time} 

    # Loop over each user.
    foreach($User in $Users){
        # Get the manager's details.
        $Manager = Get-ADUser -Identity $User.Manager -Properties DisplayName,EmailAddress

        # Add the user to the array of inactive users.
        $InactiveUsers += New-Object PSObject -Property @{
            "Username" = $User.SamAccountName
            "EmailAddress" = $User.EmailAddress
            "ManagerName" = $Manager.DisplayName
            "ManagerEmail" = $Manager.EmailAddress
            "DaysInactive" = ((Get-Date) - $User.LastLogonDate).Days
        }
    }
}

# Define the directory path where the CSV file will be saved.
$directoryPath = "C:\Temp\"

# Define the name of the CSV file to include the current date.
$fileName = "Inactive-ADUsers-" + (Get-Date -Format "dd-MM-yyyy") + ".csv"

# Combine the directory path and the file name to create the full path for the CSV file.
$filePath = $directoryPath + $fileName

# Export the results to a CSV file.
$InactiveUsers | Select-Object Username, EmailAddress, DaysInactive, ManagerName, ManagerEmail | Export-Csv -Path $filePath -NoTypeInformation
