# Dokumentation

#Pfsense
- vi har sat en Pfsense op som kører DHCP på vores Lan side og får DHCP fra Wan siden, Vores Lan side kører på netværket 10.10.30.0/24
- vi har lavet static ip mapping til vores databaseServer,WindowsServer og Pfsense så de ikke får en ny IP når leaset udløber.
- Pfsensen har den statiske IP 10.10.30.1, Vores DatabaseServer har den statiske ip 10.10.30.3 og vores WindowsServer har den statiske IP 10.10.30.2.
- Vi har sat NAT Portforwarding regler op som kører på port 5985,5986 og 3339, De kører på WAN interface, Protokollen er TCP og alle reglernes Destination er Windows Serveren 10.10.30.2
- Port 3389 (RDP) → videresendes til den interne server 10.10.30.2:3389.
- Port 5986 (PowerShell Remoting via HTTPS) → videresendes til 10.10.30.2:5986.
- Port 5985 (PowerShell Remoting via HTTP) → videresendes til 10.10.30.2:5985.


#AD OG DNS
- Vi installerede Windows Server 2025 og tildelte en statisk IP via Static DHCP mapping. Derefter tilføjede vi rollerne DNS og Active Directory Domain Services i Server Manager. Vi promoverede serveren til domænecontroller og oprettede et nyt forest med domænenavnet gruppe3.dk. Formålet med at installere AD er, at vi kan skubbe brugere direkte fra vores mock_database.csv over på AD(Vi kunne ikke komme ind på vores databaseServer så vi gjorde det med en csv) for nemt at kunne administrere dem i domænet. Til sidst testede vi ved at bruge AddADUSER.ps1 scriptet i Poweshell som vi kørte som Administrator.



