Active Directory Object Counter
--------------------------------
This simple PowerShell script can be useful when you need to know the exact object count in your Active Directory environment. The script uses the ActiveDirectory module to retrieve the count of all users, groups, and computers in your Active Directory domain and adds them together to provide a total count of objects.

Usage Examples
-------------------------------------

1.  Open PowerShell on your machine.
2.  Copy and paste the script into the PowerShell console or save it to a .ps1 file.
3.  Run the script.
4.  The script will output the total count of objects in your Active Directory environment to the console.

Here is an example of what the output may look like:
```powershell
PS C:\> .\Count-ADObjects.ps1
1050
```
In this example, the script has retrieved the count of all users, groups, and computers in the Active Directory environment and provided a total count of 1050 objects.

Note that you must have the necessary permissions to retrieve information from Active Directory in order to use this script.

Feel free to modify and use this script as needed to suit your needs.