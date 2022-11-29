Add_Remove_Users_From_Active_Directory_Group
-------------------------------------

**The script will check the OU and sub-OU’s of** "OU=yourOU,DC=yourADdomain,DC=com" **in an Active Directory domain. If there are user accounts in the OU and sub-OU’s of** "OU=yourOU,DC=yourADdomain,DC=com" **it makes them members of the AD Group defined in $groupname** 

**If any user AD account are offborarded or deleted and move to a different OU e.g. "Disabled Users" then next time this script run it will remove those AD users accounts from the AD group defined in $groupname**

**This script can be configured to run as a scheduled task with an AD Account that has the appropriate permissions to Active Directory to make changes to the AD Group defined in $groupname**
