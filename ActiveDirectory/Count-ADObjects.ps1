# Import the ActiveDirectory module into the current PowerShell session
Import-Module ActiveDirectory

# Get the count of all Active Directory users and store the count in $ADUser
$ADUser = (Get-AdUser -Filter *).Count

# Get the count of all Active Directory groups and store the count in $ADGroup
$ADGroup = (Get-ADGroup -Filter *).Count

# Get the count of all Active Directory computers and store the count in $ADComputer
$ADComputer = (Get-ADComputer -Filter *).Count

# Add the counts of all three types of Active Directory objects together and store the result in $ADObjects
$ADObjects = $ADUser + $ADGroup + $ADComputer

# Output the total count of Active Directory objects to the console
$ADObjects
