RDS Maintenance PowerShell Script 
-------------------------------------
This PowerShell script is designed to perform maintenance tasks on a Remote Desktop Services (RDS) farm. This script can be useful when a weekly reboot of the RDS Farm is needed. The script sequentially takes RDS Session Hosts out of the Host Session Pool, logs off disconnected users, reboots the servers, and then adds the servers back into the Host Session Pool.

Usage
-------------------------------------
1. Save the PowerShell script as rds_maintenance.ps1.
2. Fill in the required server hostnames for the following variables:
```powershell
$rds1 = "" #RDS Session Host 1
$rds2 = "" #RDS Session Host 2
$rdscb = "" #RDS Connection Broker
$rwb1 = "" #RDS Webserver
$fs1 = "" #RDS FileServer (if used)
```
3. Run the script in PowerShell with administrative privileges:
```powershell
.\RDS_Maintenance.ps1
```
Script Overview
-------------------------------------
The script performs the following tasks:

1. Takes RDS Server 1 out of the Host Session Pool.
2. Waits for 5 minutes.
3. Logs off any disconnected user sessions from RDS Server 1.
4. Waits for 10 minutes.
5. Reboots RDS Server 1, waits for it to come back online.
6. Waits for 5 minutes.
7. Takes RDS Server 2 out of the Host Session Pool.
8. Waits for 5 minutes.
9. Logs off any disconnected user sessions from RDS Server 2.
10. Waits for 10 minutes.
11. Reboots RDS Server 2, waits for it to come back online.
12. Waits for 10 minutes.
13. Reboots RDS Webserver, waits for it to come back online.
14. Waits for 10 minutes.
15. Reboots RDS FileServer (if used), waits for it to come back online.
16. Waits for 10 minutes.
17. Adds RDS Server 1 back into the Host Session Pool.
18. Adds RDS Server 2 back into the Host Session Pool.
19. Waits for 5 minutes.
20. Restarts the RDS Connection Broker.

Important Notes
-------------------------------------
1. Ensure you have administrative privileges to perform the tasks in the script.
2. Schedule the script during a maintenance window or at a time when users are not actively using the RDS farm.
3. Test the script in a non-production environment before running it in production.
4. Ideally, this script needs to run on the RDS Connection Broker server, as it will have the necessary PowerShell module to run cmdlets such as Set-RDSessionHost and Get-RDUserSession.
5. This script is confirmed to be working on Windows Server 2016.
6. Script can be automated and used as a scheduled task and with an AD account that has the required permissions
