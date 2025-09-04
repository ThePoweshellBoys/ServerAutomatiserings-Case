# Enable PS-Remoting
Enable-PSRemoting -Force

# Opret en fjernsession til serveren
$session = New-PSSession -ComputerName 10.10.30.2 -Credential (Get-Credential)


# Luk sessionen
Remove-PSSession $session

# Tilføj Trusted Host
Set-Item WSMan:\localhost\Client\TrustedHosts -Value "ip"

# WINRM-Services
Get-Service winrm
winrm quickconfig

#Turn ON/OFF Firewal
Set-NetFirewallProfile -Enabled True