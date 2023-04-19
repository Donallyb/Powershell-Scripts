Check-ServerReboot-Status
-------------------------------------

This PowerShell script checks if a Windows server requires a reboot by retrieving the value of the 'RebootRequired' registry key located under HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired. If the server requires a reboot, the script outputs "The server requires a reboot." Otherwise, it outputs "The server does not require a reboot."

Usage Examples
-------------------------------------

To use this script, open PowerShell on the server you want to check for a pending reboot, and run the script. You can run the script by copying and pasting it into a PowerShell prompt or by saving the script to a file with a .ps1 extension and running the file.

Here's an example of how to run the script using the Invoke-Command cmdlet to remotely check if a server requires a reboot:

```powershell
$serverName = "SERVER_NAME_HERE"

# Define the script block to run on the remote server
$scriptBlock = {
    # Paste the script here
}

# Invoke the script block on the remote server and store the result
$result = Invoke-Command -ComputerName $serverName -ScriptBlock $scriptBlock

# Output the result of the script execution
Write-Host $result
```

Replace SERVER_NAME_HERE with the name of the server you want to check. You may need to run this command with administrative privileges on the target server.