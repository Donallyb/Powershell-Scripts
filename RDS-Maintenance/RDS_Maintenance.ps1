# Define variables of the various RDS server in your RDS Farm
$rds1 = "" #RDS Session Host 1
$rds2 = "" #RDS Session Host 2
$rdscb = "" #RDS SConnection Broker
$rwb1 = "" #RDS Webserver
$fs1 = "" #RDS FileServer if one is being used

# Take RDS Server 1 out of the Host Session Pool
Set-RDSessionHost -SessionHost $rds1 -NewConnectionAllowed No -ConnectionBroker $rdscb

# Wait 5 minutes
Start-Sleep -Seconds 300

# Log off any disconnected User sessions from RDS1
Get-RDUserSession | ForEach-Object { Invoke-RDUserLogoff -HostServer $rds1 -UnifiedSessionID $_.UnifiedSessionId -Force }

# Wait 10 minutes
Start-Sleep -Seconds 600

# Reboot RDS1 - Give it 10 minutes to reboot while checking every 2 seconds that the Server is back online
Restart-Computer -ComputerName $rds1 -Force -Wait -For PowerShell -Timeout 600 -Delay 2

# Wait 5 minutes
Start-Sleep -Seconds 300

# Take RDS Server 2 out of the Host Session Pool
Set-RDSessionHost -SessionHost $rds2 -NewConnectionAllowed No -ConnectionBroker $rdscb

# Wait 5 minutes
Start-Sleep -Seconds 300

# Log off any disconnected User session from RDS2
Get-RDUserSession | ForEach-Object { Invoke-RDUserLogoff -HostServer $rds2 -UnifiedSessionID $_.UnifiedSessionId -Force }

# Wait 10 minutes
Start-Sleep -Seconds 600

# Reboot RDS2 - Give it 10 minutes to reboot while checking every 2 seconds that the Server is back online
Restart-Computer -ComputerName $rds2 -Force -Wait -For PowerShell -Timeout 600 -Delay 2

# Wait 10 minutes
Start-Sleep -Seconds 600

# Reboot RWB1 - Give it 10 minutes to reboot while checking every 2 seconds that the Server is back online
Restart-Computer -ComputerName $rwb1 -Force -Wait -For PowerShell -Timeout 600 -Delay 2

# Wait 10 minutes
Start-Sleep -Seconds 600

# Reboot FS1
Restart-Computer -ComputerName $fs1 -Wait -For PowerShell -Timeout 600 -Delay 2

# Wait 10 minutes
Start-Sleep -Seconds 600

# Add RDS Server 1 back into the Host Session Pool
Set-RDSessionHost -SessionHost $rds1 -NewConnectionAllowed Yes -ConnectionBroker $rdscb

# Add RDS Server 2 back into the Host Session Pool
Set-RDSessionHost -SessionHost $rds2 -NewConnectionAllowed Yes -ConnectionBroker $rdscb

# Wait 5 minutes
Start-Sleep -Seconds 300

# Restart RDSCB
Restart-Computer -ComputerName $rdscb -Force