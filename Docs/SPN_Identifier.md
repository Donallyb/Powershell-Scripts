Active Directory SPN Search Script
-------------------------------------

This PowerShell script is designed to search for and output all objects in specified Organizational Units (OUs) in your Active Directory environment that have a servicePrincipalName (SPN) attribute. This is useful for identifying misconfigured or duplicate SPNs, which could lead to Kerberos authentication issues.

How the script works
-------------------------------------

Utilizes Active Directory Services Interfaces (ADSI) and Directory Services .NET classes.
Searches within the specified OUs for any objects with SPNs.
Outputs information for each object, including:
Object Name
Distinguished Name (DN)
Object Category
List of servicePrincipalNames (SPNs)

How to use the script
-------------------------------------

Customize the Script: Modify the $search variable in the script to target the desired OU by replacing YourOU, YourDomain, and com with your specific OU and domain information.
Run the Script: Execute the script on a machine with necessary permissions to access your Active Directory and read object properties.
Read the Output: The script will output details directly to the console. The output includes object name, distinguished name (DN), object category, and servicePrincipalNames (SPNs) for each object within the targeted OU(s).

Example
-------------------------------------

In this example, the script is configured to search for SPNs within the Finance Organizational Unit:

```powershell
# Create a DirectorySearcher object targeting the "Finance" OU in the "contoso.com" domain.
$search = New-Object DirectoryServices.DirectorySearcher([ADSI]"LDAP://OU=Finance,DC=contoso,DC=com")
```

Requirements
-------------------------------------
PowerShell 3.0 or later.
Necessary permissions to access Active Directory and read object properties.
If you have any issues or suggestions for improving this script, please feel free to open an issue or submit a pull request.