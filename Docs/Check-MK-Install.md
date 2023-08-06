Automated Installation of Checkmk Agents on Windows Hosts
-------------------------------------

This repository provides a PowerShell script and accompanying batch file that facilitate the automated installation and registration of Checkmk agents on Windows hosts.

Features
-------------------------------------
Secure collection of Checkmk credentials.
Silent installation of the Checkmk agent from a specified MSI.
Registration of the agent using an external batch file (commands.bat).
Automatic handling of any prompts during the installation and registration process.
Post-installation verification to ensure successful agent installation.

Pre-requisites
-------------------------------------
A PowerShell session opened with Run as Administrator privileges.
The Checkmk agent MSI installer should be placed in a known directory.
Ensure the commands.bat file is in the same directory as the installation script.

Usage
-------------------------------------
Clone the repository to your local machine or server.

Navigate to the directory containing the scripts.

Open a PowerShell session 'Run as Administrator'.

Execute the script:

```powershell
powershell.exe -File "path_to_the_script.ps1"
```
When prompted, enter your Checkmk credentials.


How It Works
-------------------------------------
The PowerShell script starts by gathering your Checkmk credentials in a secure manner.
It then initiates the silent installation of the Checkmk agent using the provided MSI installer.
After installation, it calls the accompanying batch file (commands.bat) to register the agent. This registration is done via a command prompt running with administrative privileges.
The script concludes by verifying the successful installation of the agent and provides feedback in the console.

Important Note
-------------------------------------
Given the nature of this installation:

Some components of the script MUST be run with administrative privileges due to inherent requirements of the Checkmk agent. For a deeper dive into these requirements, please refer to the official Checkmk documentation.

The registration step requires elevated command prompt access, which is why an external batch file is utilized.

Caution is advised: Running the batch file will expose the password entered at the start of the script. For enhanced security, it's recommended to use a designated Checkmk user account with the necessary rights to register hosts on sites. This account should ideally have a lengthy and complex password to mitigate potential security risks.

Important Note on Hostname Case Sensitivity
-------------------------------------
The script retrieves the current server's hostname and converts it to uppercase using the following code:

```powershell
# Get the current server hostname. Ensure the hostname is in upper-case to match the CheckMK site registration requirement.
$hostname = (hostname).ToUpper()
```
This step is crucial for a key reason: The hostname of the server as registered on the Checkmk site must also be in uppercase. If there's a mismatch between the hostname registered on the Checkmk site and the one provided by the script — for instance, one being in lowercase while the other is in uppercase — the agent will fail to register correctly. Always ensure that the hostname on your Checkmk site matches the case (upper-case) as provided by the script to avoid registration issues.

Contribute
-------------------------------------
Feel free to fork this project, submit issues, or provide pull requests. Any form of contribution is welcomed!