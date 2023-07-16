#Importing the ActiveDirectory module to work with Active Directory cmdlets
Import-Module ActiveDirectory

# Below is a commented out example on how to generate the encrypted password string
# It needs to be done on the computer and by the service account running this script
#   $secure = Read-Host -AsSecureString
#   <Enter in the password>
#   $encrypted = ConvertFrom-SecureString -SecureString $secure
#   $encrypted
#   <Copy the value which is displayed, and paste it in as the value below>

# The password for the service account is stored as a secure string
$Encrypted = ""
# Provide the service used to autenticate with Azure AD and has the permissions to change Users Password Policy
$User = "serviceaccount@example.com"
$Password = ConvertTo-SecureString -String $Encrypted
# Creating a PSCredential object using the service account username and password
$credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $Password
# Connect to Azure Active Directory using the above credentials
Connect-AzureAD -credential $credential | Out-Null

# Consolidate OU paths into an array
$OUList = @(
    'OU=Example1,OU=ServiceAccounts,DC=contoso,DC=com',
    'OU=Example2,OU=ServiceAccounts,DC=contoso,DC=com',
    'OU=Example3,OU=ServiceAccounts,DC=contoso,DC=com'
)

# Initialize an empty array to hold all userPrincipalNames
$AllOU = @()

# Loop over each OU and get the userPrincipalName for each user with 'passwordNeverExpires' set to true and account enabled
foreach ($ou in $OUList) {
    $users = Get-ADUser -SearchBase $ou -Filter {(passwordNeverExpires -eq $true) -and (enabled -eq $true)} | Select-Object -ExpandProperty userPrincipalName
    # Add the users to the AllOu array
    $AllOU += $users
}

# For each user, check and set 'DisablePasswordExpiration' policy in Azure AD
foreach ($account in $AllOU) {
    if($null -ne $account){
        try {
            $onPremServiceAccountsSyncedToAAD = (Get-AzureADUser -ObjectID $account).passwordpolicies
            if ($onPremServiceAccountsSyncedToAAD -ne "DisablePasswordExpiration") {
                Set-AzureADUser -ObjectID $account -PasswordPolicies "DisablePasswordExpiration"                
            }
        }
        catch {
            # Using format operator
            Write-Output ("Error processing user {0}: {1}" -f $account, $_)
           
            # Alternatively, using braces to enclose variable names
            # Write-Output "Error processing user ${account}: ${_}"
        }
    }
    else {
        Write-Output "No userPrincipalName found for a user."
    }
}