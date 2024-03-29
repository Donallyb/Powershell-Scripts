Automated Installation of Checkmk Agents on Windows Hosts
-------------------------------------

This repository provides a PowerShell script and accompanying batch file that facilitate the automated installation and registration of Checkmk agents on Windows hosts.

Features
-------------------------------------
* Secure collection of Checkmk credentials.
* Silent installation of the Checkmk agent from a specified MSI.
* Registration of the agent using an external batch file (commands.bat).
* Automatic handling of any prompts during the installation and registration process.
* Post-installation verification to ensure successful agent installation.

Pre-requisites
-------------------------------------
* A PowerShell session opened with Run as Administrator privileges.
* The Checkmk agent MSI installer should be placed in a known directory.
* Ensure the commands.bat file is in the same directory as the installation script.

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

Console Window Management and Agent Registration
-------------------------------------
The portion of the script from line 62 deals with managing the console window and initiating the Checkmk agent registration:

1. Console Window Type Definition:

* The script first defines a .NET type to interact with the User32.dll. This allows for direct control over the console window.
* The ShowWindow function, imported from User32.dll, is used to control the visibility and foreground status of the console window.

2. Fetching Current Console Handle:

* The script retrieves the window handle of the currently executing process (PowerShell console). This handle is essential for directly manipulating the console window.

3. Bringing Console Window to Foreground:

* Using the previously defined type, the script brings the PowerShell console window to the forefront. 
* This ensures that any subsequent input or action happens in the active, foremost window.

4. Agent Registration Process:

* The script starts the agent registration process using the Checkmk agent's executable (cmk-agent-ctl.exe). 
* The necessary arguments for registration, such as hostname, server, site, and user credentials, are provided.
* After initiating the registration process, the script waits briefly, allowing the process to commence and display potential prompts or messages.

5. Automatic Confirmation:

* The script uses the SendKeys method to send a 'Y' key press, followed by the ENTER key, to the active window. 
* This automates the confirmation process, which might arise during the agent registration, thus streamlining the setup.

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