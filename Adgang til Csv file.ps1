# Path to CSV
$csvPath = "C:\Users\micha\Downloads\mock_database.csv"

# Check if the file exists
if (-Not (Test-Path $csvPath)) {
    Write-Host "CSV file not found at $csvPath"
    exit
}

# Import CSV
try {
    $data = Import-Csv -Path $csvPath
    Write-Host "CSV loaded successfully. Rows: $($data.Count)"
} catch {
    Write-Host "Failed to load CSV: $_"
    exit
}

# Example: Display all rows
$data | ForEach-Object {
    Write-Host ($_ | Out-String)
}

