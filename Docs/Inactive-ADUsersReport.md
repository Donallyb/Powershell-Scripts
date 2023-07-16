Inactive AD Users Report
-------------------------------------

This PowerShell script is designed to identify inactive users in your Active Directory environment. The script will scan specific Organizational Units (OUs) and find users who have not logged in within a specified number of days. The results will be exported to a CSV file for further analysis.

How to use the script
-------------------------------------

*Imports Active Directory Module.
*Allows defining inactivity based on a specific number of days.
*Permits the specification of multiple Organizational Units (OUs) to search within.
*Creates a list of inactive users including:
    *Username
    *Email Address
    *Manager Name
    *Manager Email
    *Number of Inactive Days
*Exports the data to a CSV file.


How to use the script
-------------------------------------

1. Customize the Script: Modify the DaysInactive variable to set the number of days to consider a user as inactive. Adjust the OUs array with the Distinguished Names (DN) of the OUs you wish to search.
2. Run the Script: Execute the script on a machine with the Active Directory PowerShell Module installed and the necessary permissions to access your Active Directory.
3. Access the Report: The report will be saved as a CSV file in the directory specified by the $directoryPath variable. The file name will be prefixed with "Inactive-ADUsers-" and suffixed with the current date.

Example
-------------------------------------

In this example, the script is configured to search for users who have not logged in for 90 days in four different Organizational Units: Finance, HR, NY, and LA.

```powershell
# Import the Active Directory module.
Import-Module ActiveDirectory

# Define the number of days to consider a user as inactive.
$DaysInactive = 90

# Calculate the date X days ago (where X is the value of $DaysInactive) from the current date.
$time = (Get-Date).Adddays(-($DaysInactive))

# Define the list of OUs to search for inactive users. 
$OUs = "OU=Finance,OU=Users,DC=contoso,DC=com", 
        "OU=HR,OU=Users,DC=contoso,DC=com", 
        "OU=NY,OU=Users,DC=contoso,DC=com",
        "OU=LA,OU=Users,DC=contoso,DC=com"

```

The resulting CSV file will be named something like "Inactive-ADUsers-16-07-2023.csv" and will be located in the "C:\Temp" directory.

Requirements
-------------------------------------
*PowerShell 3.0 or later.
*Active Directory PowerShell Module.
*Necessary permissions to access Active Directory and read user properties.