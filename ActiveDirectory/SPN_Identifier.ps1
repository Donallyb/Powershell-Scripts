# Create a DirectorySearcher object
# This is a .NET object used for performing searches against an Active Directory (AD) 
# Here, it is initialized with the root of the LDAP directory tree, 
# which is your root Active Directory domain
$search = New-Object DirectoryServices.DirectorySearcher([ADSI]"LDAP://OU=YourOU,DC=YourDomain,DC=com")

# The Filter property of the DirectorySearcher object specifies the criteria for the search.
# In this case, the filter is looking for any AD objects with a servicePrincipalName (SPN) attribute
$search.Filter = "(servicePrincipalName=*)"

# The PropertiesToLoad method of the DirectorySearcher object specifies the attributes of the AD objects 
# that the search should return
# Here, it is set to return the name, distinguishedName, objectCategory, and servicePrincipalName attributes
$search.PropertiesToLoad.AddRange(@('name', 'distinguishedName', 'objectCategory', 'servicePrincipalName'))

# The FindAll method of the DirectorySearcher object performs the search
# based on the Filter and PropertiesToLoad settings, and stores the results
$results = $search.Findall()

# The foreach loop iterates through each result returned by the search
foreach($result in $results) {
    # For each result, the GetDirectoryEntry method is called to return the AD object
    # associated with that search result
    $userEntry = $result.GetDirectoryEntry()

    # Write-Host is used to print information about the AD object to the console
    # Here, it prints the object's name, distinguishedName, objectCategory, 
    # and a heading for the servicePrincipalNames
    Write-Host "Object Name = " $userEntry.name
    Write-Host "DN = " $userEntry.distinguishedName
    Write-Host "Object Cat. = " $userEntry.objectCategory
    Write-Host "servicePrincipalNames"

    # Another foreach loop is used to iterate through each servicePrincipalName 
    # (SPN) associated with the AD object
    # SPNs are used in Kerberos authentication to associate a service instance 
    # with a service logon account
    $i = 1
    foreach($SPN in $userEntry.servicePrincipalName) {
        # Each SPN is printed to the console
        Write-Host "SPN ${i} = $SPN"
        $i++
    }

    # A blank line is printed to the console for readability before the next AD object's details are printed
    Write-Host ""
}
