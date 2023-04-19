Remote Servers Cumulative Update Check
-------------------------------------

This PowerShell script checks whether the latest Windows cumulative update is installed on multiple remote servers. It provides an easy way to verify that your servers are up to date with the latest security patches.

Requirements
-------------------------------------

1. PowerShell version 3.0 or later
2. Remote servers running supported versions of Windows Server
3. Administrator rights on the remote servers
4. PowerShell remoting enabled on the remote servers

Usage
-------------------------------------

1. Clone or download the script from this repository.
2. Open the script in a text editor (e.g., Notepad, Visual Studio Code).
3. Replace the $RemoteServer array with the actual names or IP addresses of the remote servers you want to check. For example:

```powershell
$RemoteServer = @("Server1", "Server2", "Server3");
```

4. Update the $LatestUpdate variable with the latest cumulative update information from the Microsoft Update Catalog. For example, using the HotFixID "KB5023697" for Windows Server 2016 in March 2023:

```powershell
$LatestUpdate = @{
    HotFixID = "KB5023697"
}
```

5. Save the changes and close the text editor.
6. Open a PowerShell console with administrator privileges.
7. Navigate to the directory where the script is saved.
8. Run the script by using .\Check-LatestInstalledCU.ps1, in PowerShell
9. The script will display the cumulative update status for each remote server in the console, using green text for servers with the latest update installed and red text for servers without the latest update.

Usage
-------------------------------------
Make sure that you have proper administrative credentials and PowerShell remoting enabled on the remote servers to successfully execute the script.
The colored output will only work in a PowerShell console or terminal. If you redirect the output to a file or another application, the color information will not be preserved.