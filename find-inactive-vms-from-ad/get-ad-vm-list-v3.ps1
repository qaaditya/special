$DaysInactive = 90
$time = (Get-Date).Adddays(-($DaysInactive))
Get-ADComputer -Filter {LastLogonTimeStamp -lt $time} -ResultPageSize 2000 -resultSetSize $null -Properties Name,DNSHostname,Enabled | Export-CSV “C:\Temp\HostNames.csv” –NoTypeInformation 
#$time = (Get-Date).Adddays(-($DaysInactive))
#Get-ADComputer -Filter {LastLogonTimeStamp -lt $time} -ResultPageSize 2000 -resultSetSize $null -Properties Name,DNSHostname,Enabled | Format-Table Name,DNSHostname,Enabled | Out-File -FilePath “C:\Temp\HostNames.txt”

Get-Content -Path “C:\Temp\HostNames.csv” | Where-Object {$_ -like '*True*'} | Out-File -FilePath “C:\Temp\active_vms.txt”

#Export-CSV “C:\Temp\active_vms.csv” –NoTypeInformation 

$computers=import-csv “C:\Temp\active_vms.txt” -Delimiter "," –header DistinguishedName, DNSHostName, Enabled, Name, ObjectClass, ObjectGUID, SamAccountName, SID, UserPrincipalName

Foreach ($el in $computers) {
    Write-Host "VM is $($el.DNSHostName)"
}

#        # Disable-ADAccount -Identity $($el.DNSHostName)$
