#Set Path for the workdir
$workdir = "c:\Site24x7Setup\"

$thirtytwobit = Test-Path -Path "C:\Program Files (x86)"

$Site24x7Installed = Test-Path -Path "C:\Program Files (x86)\Site24x7"

If ($Site24x7Installed){
Write-Host "Site24x7 Agent Already Installed!" -ForegroundColor Red
Exit
} ELSE {
Write-Host "Beginning the installation of Site24x7 Agent"-ForegroundColor green

#Check if the work directory exists if not create it

If (Test-Path -Path $workdir -PathType Container){
Write-Host "$workdir already exists" -ForegroundColor Red
} ELSE {
New-Item -Path $workdir -ItemType directory
}

#Download the S24x7 installer agent

$source = "https://staticdownloads.site24x7.com/server/Site24x7WindowsAgent.msi"
$destination = "$workdir\Site24x7WindowsAgent.msi"

#Check if Invoke-Webrequest exists otherwise execute WebClient

if (Get-Command 'Invoke-Webrequest'){
Invoke-WebRequest $source -OutFile $destination
} else {
$WebClient = New-Object System.Net.WebClient
$webclient.DownloadFile($source, $destination)
}

#Start the installation of the S24x7 Agent

Start-Process -WorkingDirectory $workdir msiexec.exe -Wait -ArgumentList '/i Site24x7WindowsAgent.msi EDITA1=<Your-Device-Key-Here> ENABLESILENT=YES REBOOT=ReallySuppress /qn'

Start-Sleep -s 60

#Clean-up Remove the workdir

Remove-Item –path $workdir -recurse

Write-Host "Site24x7 Agent Installed" -ForegroundColor Green

}
