Scheduled Reboot PowerShell Script
-------------------------------------

This repository contains a PowerShell script that allows you to schedule a one-time reboot of a server at a specific time, such as 8 PM. The script calculates the number of seconds until the desired reboot time and schedules a one-time reboot using the shutdown.exe command with appropriate options.

How to use the script
-------------------------------------

1. Open PowerShell on your server.
2. Save the following script as ScheduledReboot.ps1:

```powershell
# Set the desired reboot time
$rebootTime = '20:00' # 8 PM

# Get the current date and time
$currentDateTime = Get-Date

# Create a new DateTime object for the desired reboot time (8 PM) on the current date
$rebootDateTime = $currentDateTime.Date.Add([timespan]::Parse($rebootTime))

# Check if the desired reboot time has already passed for today
if ($rebootDateTime -lt $currentDateTime) {
    # If the desired reboot time has passed, add one day to schedule the reboot for the next day at 8 PM
    $rebootDateTime = $rebootDateTime.AddDays(1)
}

# Calculate the number of seconds until the reboot time
$secondsUntilReboot = [int](($rebootDateTime - $currentDateTime).TotalSeconds)

# Schedule the reboot using the shutdown.exe command
# /r: Full shutdown and restart
# /t: Time-out period before shutdown in seconds
# /c: Comment on the reason for the restart or shutdown
# /d: Provide the reason for the restart or shutdown (p:4:1 for planned application maintenance)
shutdown.exe /r /t $secondsUntilReboot /c "Scheduled reboot at 8 PM" /d p:4:1

```

3. Open PowerShell and navigate to the directory where you saved the script.
4. Run the script using the following command:

```powershell
.\ScheduledReboot.ps1
```

This will schedule a one-time reboot of your server at the specified time (e.g., 8 PM). If the desired reboot time has already passed for the current day, the script will schedule the reboot for the next day at the specified time.

Customizing the reboot time
-------------------------------------
To schedule the reboot at a different time, change the value of the $rebootTime variable in the script. For example, to schedule the reboot at 10 PM, change the line:

```powershell
$rebootTime = '20:00' # 8 PM
```

to:

```powershell
$rebootTime = '22:00' # 10 PM
```
Additional information
-------------------------------------
This script uses the shutdown.exe command with the following options:

/r: Full shutdown and restart
/t: Time-out period before shutdown in seconds
/c: Comment on the reason for the restart or shutdown
/d: Provide the reason for the restart or shutdown (p:4:1 for planned application maintenance)
For more information on the shutdown.exe command and its options, consult the Microsoft documentation.