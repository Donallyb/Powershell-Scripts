Add_Remove_Users_From_Active_Directory_Group
-------------------------------------

The "Add_Remove_Users_From_Active_Directory_Group" script is designed to check the Organizational Units (OU) and sub-OUs in an Active Directory domain. Specifically, it will check the OU and sub-OUs for "OU=yourOU,DC=yourADdomain,DC=com". If there are user accounts within this OU and its sub-OUs, the script will make them members of the Active Directory group specified in the $groupname variable.

If a user account is offboarded or deleted and moved to a different OU, such as "Disabled Users," the script will detect this change during the next run and remove the user's account from the AD group specified in $groupname.

The script is intended to be scheduled to run automatically using Windows Task Scheduler and using an AD account that has the appropriate permissions to make changes to the AD group defined in $groupname. This allows for easy management and maintenance of the AD group without requiring manual intervention.

Overall, this script provides a simple and effective way to manage user accounts in Active Directory and ensure that they are added or removed from specific AD groups as needed.
