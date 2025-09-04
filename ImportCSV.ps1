function Get-uniqueAccountName {
    param ($firstname, $lastname)
    
    $initials = $firstname[0] + $lastname.Substring(0,1);
    return $initials;

}
$data = Import-Csv -Path "C:\Users\micha\Downloads\mock_database.csv"
$users = foreach ($mock_database in $data) {
    $firstname = $mock_database.firstname.trim();
    $lastname = $mock_database.lastname.trim();
    $uniqueaccountname = get-UniqueAccountName $firstname $lastname;

    [PSCustomObject]@{
        Name = "$firstname $lastname";
        GivenName = $firstname;
        SamAccountName = $uniqueAccountName;
        Userprincipalname = "$uniqueAccountName@gruppe3.dk"
        Accountpassword = ""
        Enabled = $true;

    }
}

Write-Output($users);