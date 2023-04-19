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