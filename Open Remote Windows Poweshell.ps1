# Enable PS-Remoting
Enable-PSRemoting -Force

# Opret en fjernsession til serveren
$session = New-PSSession -ComputerName 10.101.232.173 -Credential (Get-Credential)


# Luk sessionen
Remove-PSSession $session

# Tilføj Trusted Host
Set-Item WSMan:\localhost\Client\TrustedHosts -Value "10.101.232.173"

# WINRM-Services
Get-Service winrm
winrm quickconfig

#Turn ON/OFF Firewal

Set-NetFirewallProfile -Enabled True
