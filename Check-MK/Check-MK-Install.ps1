<#
    Description:
    Eases the Install of the Check-MK Agent on Windows Servers.

    Features:
    - Securely gathers Check MK credentials.
    - Installs the Check MK agent from a specified MSI.
    - Runs Commands.bat post-install for registration.
    - Auto-confirms prompts.
    - Verifies installation, providing console feedback.

    Usage:

    1. Log onto the server.
    2. **Ensure you open a PowerShell session 'Run as Administrator'.**
    3. Place the Check-MK Agent MSI in a known location.
    4. Ensure Commands.bat is in the same directory as this script.
    5. Run with:
       `powershell.exe -File "script_path"`
       (Replace script_path with your script's actual path)
    6. Provide Check MK credentials when prompted.

    Note: Always test scripts in a safe environment before deployment.

#>

# Load the assembly required for SendKeys
Add-Type -AssemblyName System.Windows.Forms

# Request and verify credentials for Check MK
# This command will prompt the user to input their Check MK credentials in a secure manner
$checkmkCredentials = Get-Credential -Message "Enter your Check MK credentials here"
# Extract the username from the provided credentials
$checkmkUsername = $checkmkCredentials.UserName
# Extract the password from the provided credentials
$checkmkPassword = $checkmkCredentials.GetNetworkCredential().Password
# Define the location of the CheckMK agent installer
$CheckMKAgentLocation = "PATH_TO_YOUR_MSI_HERE"  # e.g., "C:\path\to\installer.msi"
# Define Commands.bat batch file location
$batchFileLocation = "PATH_TO_YOUR_BATCH_FILE_HERE"  # e.g., "C:\path\to\Commands.bat"
# Define the CheckMK Server
$CheckMKServer = "YOUR_CHECKMK_SERVER_HERE"  # e.g., "checkmk.yourdomain.com"
# Define the CheckMK Site
$CheckMKSite = "YOUR_CHECKMK_SITE_NAME_HERE"  # e.g., "mysite"
# Get the current server hostname. Ensure the hostname is in upper-case to match the CheckMK site registration requirement.
$hostname = (hostname).ToUpper()


# Perform the installation of the CheckMK agent using msiexec
# The installer is run with the /qn switch for silent installation, and additional options are passed
Start-Process msiexec -Wait -ArgumentList "/I `"$CheckMKAgentLocation`" /qn WIXUI_CLEANINSTALL= WIXUI_MIGRATELEGACY=''"

# Pause for 60 seconds to let the installer finish
Start-Sleep -Seconds 60

# Call the batch file and run CMD as an Administrator in order to register the agent
Start-Process -FilePath "cmd.exe" -ArgumentList "/c $batchFileLocation $hostname $checkmkUsername $checkmkPassword" -Verb RunAs

# Wait for a few seconds for the process to complete
Start-Sleep -Seconds 10

# Define a type to call into the User32 DLL, allowing us to control the console window
Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    public class ConsoleWindow {
        [DllImport("user32.dll")]
        public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
    }
"@

# Get the console window handle associated with the current process
$consoleHandle = (Get-Process -id $pid).MainWindowHandle

# Bring console window to the foreground
[ConsoleWindow]::ShowWindow($consoleHandle, 5)

# Start the process for agent registration and capture the process in a variable
Start-Process -FilePath "C:\Program Files (x86)\checkmk\service\cmk-agent-ctl.exe" -ArgumentList "register --hostname $hostname --server $CheckMKServer --site $CheckMKSite --user $checkmkUsername --password $checkmkPassword" -PassThru

# Give the process some time to start and display the prompt for input
Start-Sleep -Seconds 2

# Send 'Y' key to the process window to automatically confirm any prompts
[System.Windows.Forms.SendKeys]::SendWait('Y{ENTER}')

# Make sure the 'Y' key is processed before continuing
Start-Sleep -Seconds 2

# Pause for 30 seconds to let the registration process complete
Start-Sleep -Seconds 15

# Check if the software is installed
$software = Get-WmiObject -Query "SELECT * FROM Win32_Product WHERE (Name LIKE 'Check MK Agent 2.2%')" 

# If the software is found, output a success message
if ($software) {
    Write-Host "Check MK Agent installed on: $hostname" -ForegroundColor Green
}
# If the software is not found, output a failure message
else {
    Write-Host "Check MK Agent HAS NOT been installed on: $hostname" -ForegroundColor Red
}
