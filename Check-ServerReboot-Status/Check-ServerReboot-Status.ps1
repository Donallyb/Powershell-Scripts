# This line retrieves the value of the 'RebootRequired' registry key located under HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired.
# The '-ErrorAction SilentlyContinue' parameter is used to suppress any errors that may occur when attempting to retrieve the registry key value.
$RebootRequired = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired' -ErrorAction SilentlyContinue).RebootRequired

# This line checks if the value of $RebootRequired is true. If the server requires a reboot, the script will output "The server requires a reboot."
if ($RebootRequired) {
    Write-Host "The server requires a reboot."
} 
# If the value of $RebootRequired is false, the script will output "The server does not require a reboot."
else {
    Write-Host "The server does not require a reboot."
}
