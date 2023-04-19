# Define an array of remote servers by replacing 'Server1' and 'Server2' with the actual names or IP addresses
$RemoteServer = @("Server1", "Server2", "Server3")

# Manually set the latest cumulative update information by specifying the HotFixID
# You can obtain the HotFixID from the Microsoft Update Catalog
$LatestUpdate = @{
    HotFixID = ""
}

# Define the script block to execute on the remote server(s)
$ScriptBlock = {
    # Get all the installed updates on the remote server using the Get-HotFix cmdlet
    $InstalledUpdates = Get-HotFix

    # Filter the installed updates to find the latest cumulative update
    # by comparing the HotFixID with the one specified in the $LatestUpdate variable
    $LatestInstalledCU = $InstalledUpdates | Where-Object { $_.HotFixID -eq $using:LatestUpdate.HotFixID }

    # Check if the latest cumulative update is installed
    if ($LatestInstalledCU) {
        # If the latest update is installed, display a success message in green text
        $Message = "The latest cumulative update ({0}) is installed on {1}." -f $using:LatestUpdate.HotFixID, $env:COMPUTERNAME
        Write-Host $Message -ForegroundColor Green
    } else {
        # If the latest update is not installed, find the most recent security update
        $LatestCUFound = $InstalledUpdates | Where-Object { $_.Description -eq "Security Update" } | Sort-Object InstalledOn -Descending | Select-Object -First 1
        # Display a warning message in red text, including the latest installed update's HotFixID
        $Message = "The latest cumulative update ({0}) is NOT installed on {1}. The latest installed cumulative update is {2}." -f $using:LatestUpdate.HotFixID, $env:COMPUTERNAME, $LatestCUFound.HotFixID
        Write-Host $Message -ForegroundColor Red
    }
}

# Invoke the script block on each remote server using Invoke-Command
# This will execute the script block on the specified remote servers and return the output to the local console
Invoke-Command -ComputerName $RemoteServer -ScriptBlock $ScriptBlock
