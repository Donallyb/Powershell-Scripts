Install Site24x7 Agent Silently 
-------------------------------------

**The script will download the latest version of the Site24x7 agent for Windows Server and install it silently on the server and associate it with your Site24x7 account using the Device Key that belongs to your account.** 

**Script can detect if Site24x7 is already installed on a server and will stop the script, otherwise, it will proceed with the install. Once the Site24x7 agent install is complete it will clean-up all the set-up files.**

Where to Find the Site24x7 Device Key for your account.
-------------------------------------
1. Login to your Sites24x7 Account
2. Go to Admin -> Developer -> Device Key -> Select "Show Device Key"
3. On line 38 in the script replace "Your-Device-Key-Here" with the Device Key of your account

Usage Examples - Installing Site24x7 agent on Multiple Servers
-------------------------------------

Invoke-Command -ComputerName server1, server2, server3 -FilePath "C:\temp\Install-Site24x7.ps1"
