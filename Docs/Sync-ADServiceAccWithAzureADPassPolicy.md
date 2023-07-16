Sync-ADServiceAccWithAzureADPassPolicy
-------------------------------------

The Sync-ADServiceAccWithAzureADPassPolicy PowerShell script is designed to synchronize the password policy of service accounts in Active Directory (AD) with their counterparts in Azure Active Directory (Azure AD).

Overview
-------------------------------------

In an environment where Password Hash Synchronization is configured via AD Connects, a discrepancy can arise if a service account's password gets reset in on-premise AD, causing the password policy for the same account in Azure AD to be reset to "None".

When set to "None", the account in Azure AD follows the default password policy for normal user accounts, which might require password changes, for example, every 90 days. However, if the service account in on-premise AD has its policy set to "Password Never Expires", this discrepancy can cause confusion and lead to unnecessary troubleshooting.

The Sync-ADServiceAccWithAzureADPassPolicy script mitigates this issue by ensuring that service accounts in Azure AD also have the "DisablePasswordExpiration" policy if their counterparts in the on-premise AD have the "Password Never Expires" policy.

Prerequisites
-------------------------------------
To use this script, the following requirements must be met:

An Azure AD tenant with service accounts synced from on-premise AD.
The ActiveDirectory PowerShell module installed on your machine.
The Azure AD PowerShell module (AzureAD).
A service account that has the required permissions to change users' password policies in Azure AD. This account will be used to authenticate with Azure AD.
The $User variable in the script should be replaced with the username of your service account that has the necessary permissions in Azure AD to change users' password policies from "None" to "DisablePasswordExpiration".

This script is designed to be run on an on-premise Windows server, and the password for the service account used to authenticate with Azure AD is encrypted specifically for the Windows server where the script is running.

How to use the script
-------------------------------------
Here is a step-by-step guide on how to use the script:

1. Before running the script, you need to generate the encrypted password string for the service account. This should be done on the computer and by the service account running this script. Follow the commented out example in the script to generate the encrypted password string and save it.

2. Replace the value of the $Encrypted variable with your generated encrypted password string.

3. Replace the value of $User with the username of your service account with the appropriate Azure AD permissions.

4. Adjust the Organizational Units (OU) paths inside the $OUList array to fit your environment.

5. Run the script. The script will connect to Azure AD using the provided service account credentials, fetch the service accounts from the specified OUs in your on-premise AD that have 'PasswordNeverExpires' set to true and are enabled.

6. For each service account, it checks and sets the 'DisablePasswordExpiration' policy in Azure AD. If it encounters any issues, the error will be logged in the output.

To ensure that the password policy synchronization is up-to-date, consider setting up this script as a Scheduled Task on your Windows server to run automatically on a regular basis, such as daily or weekly. This is particularly useful to prevent scenarios where the on-premise service account password changes, either accidentally or due to routine password rotation, and as a result, the password policy in Azure AD changes to "None". By running this script on a schedule, you can ensure that any such changes are mitigated in a timely manner.

Troubleshooting
-------------------------------------

If you encounter any issues while running the script, check the output logs. They provide detailed information about any users the script failed to process and the reasons for the failure. The script is designed to handle and report errors gracefully, ensuring you have all the information you need to troubleshoot effectively.