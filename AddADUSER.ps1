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
        Accountpassword = "1234"
        Enabled = $true;

    }
}

Write-Output($users);

$Session = New-PSSession -Computername 10.101.232.173 -Credential Administrator
try {
    $targetOU2 = "OU=Users,DC=Gruppe3"
    Invoke-Command -Session $Session -ArgumentList $users, $targetOU2 -ScriptBlock {
        param ($users, $targetOU)
        Import-Module ActiveDirectory
        
        foreach($user in $users) {

            if (-not (Get-ADuser -LDAPFilter "(SamAccountName=$($user.SamAccountName))" -ErrorAction SilentlyContinue)) {

                $SecurePwd = ConvertTo-SecureString $user.AccountPassword -AsPlainText -Force

                New-ADuser `
                    -Name $user.Name `
                    -GivenName $user.GivenName `
                    -SamAccountName $user.SamAccountName `
                    -UserPrincipalName $user.UserPrincipalName `
                    -AccountPassword $SecurePwd `
                    -Enabled $user.Enabled `
                    -ChangePasswordAtLogon $true
                Write-Host "User $($user.SamAccountName) created successfully."
            }
            else {
                Write-Host "User $($user.SamAccountName) already exists. Skipping creation."
            }
        }
    }
}
finally {
    Remove-PSSession -Session $Session
    Write-Host "Session closed."
}

