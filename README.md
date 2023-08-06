PowerShell Scripts
-------------------------------------

**Useful day to day PowerShell Scripts for various tasks and workloads**

Scripts for Azure AD
-----------------------------

| Script                                               | Description                                                                                     |
| ---------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| [Sync-ADServiceAccWithAzureADPassPolicy.ps1](AzureAD/Sync-ADServiceAccWithAzureADPassPolicy.ps1)           | This script aligns on-premise and Azure AD service account password policies, preventing potential discrepancies. [Read more...](Docs/Sync-ADServiceAccWithAzureADPassPolicy.md)                  |

Scripts for Active Directory
-----------------------------

| Script                                               | Description                                                                                     |
| ---------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| [Add_Remove_Users_From_Active_Directory_Group.ps1](ActiveDirectory/Add_Remove_Users_From_Active_Directory_Group.ps1)           | Automate AD Group Membership. [Read more...](Docs/Add_Remove_Users_From_Active_Directory_Group.md)                  |
| [Count-ADObjects.ps1](ActiveDirectory/Count-ADObjects.ps1)           | Get object count of your AD environment. [Read more...](Docs/Count-ADObjects.md)                  |
| [Inactive-ADUsersReport.ps1](ActiveDirectory/Inactive-ADUsersReport.ps1)           | Generate a Report of Inactive Users in your AD Environment [Read more...](Docs/Inactive-ADUsersReport.md)                  |
| [SPN_Identifier.ps1](ActiveDirectory/SPN_Identifier.ps1)           | This script scans a specified Active Directory OU for objects with servicePrincipalName attributes to help identify potential Kerberos authentication issues [Read more...](Docs/SPN_Identifier.md)                  |

Scripts for Windows Server Maintenance
-----------------------------

| Script                                               | Description                                                                                     |
| ---------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| [Check-LatestInstalledCU.ps1](Server-Maintenance/Check-LatestInstalledCU.ps1)           | Check Latest installed CU on a Windows Server. [Read more...](Docs/Check-LatestInstalledCU.md)                  |
| [Check-ServerReboot-Status.ps1](Server-Maintenance/Check-ServerReboot-Status.ps1)           | Verify if a Windows Server is in a Reboot State. [Read more...](Docs/Check-ServerReboot-Status.md)                  |
| [ScheduledReboot.ps1](Server-Maintenance/ScheduledReboot.ps1)           | Easily schedule a Windows server Reboot time [Read more...](Docs/ScheduledReboot.md)                  |

Scripts for Monitoring Agents
-----------------------------

| Script                                               | Description                                                                                     |
| ---------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| [Install-Site24x7.ps1](Install-Site24x7/Install-Site24x7.ps1)           | Install Site24x7 Agent Silently. [Read more...](Docs/Install-Site24x7.md)                  |
| [Check-MK-Install.ps1](Check-MK/Check-MK-Install.ps1)           | Eases the Install of the Check-MK Agent on Windows Servers. [Read more...](Docs/Check-MK-Install.md)                  |

Script for Performing RDS Farm Maintenance
-----------------------------------------

| Script                                               | Description                                                                                     |
| ---------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| [RDS-maintenance.ps1](RDS-Maintenance/RDS_Maintenance.ps1)           | Perfrom Maintenace on a RDS Server Farm. [Read more...](Docs/RDS-Maintenace.md)                  |

Feedback
--------
Send your email feedback to: donalbolger [at] gmail [dot] com

License & Copyright
-------------------
This open source project is licensed under the CC0 license. All trademarks are the property of their respective owners.