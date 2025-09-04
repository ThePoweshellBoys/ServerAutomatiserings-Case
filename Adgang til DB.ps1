Add-Type -Path "C:\Users/Downloads/MySql.Data.dll"

$serveraddress = "10.10.30.3"
$databasename = "HotelDB";
$username = "Owner";
$password = "Kode1234!"

$connectingString = "Server=$serveraddress;Database=$databasename;User Id=sa;Password=$username $password;"

$connection = New-Object MySql.Data.MySqlClient.MySqlConnection
$connection.ConnectionString = $connectingString

try {
    $connection.Open()
    Write-Host "Connection to database successful."
} catch {
    Write-Host "Failed to connect to database: $"
    exit
}